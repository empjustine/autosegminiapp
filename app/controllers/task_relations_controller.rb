class TaskRelationsController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout "application"

  def index
    @task_relations = TaskRelation.all_visible(current_user)
    @favourites = TaskRelation.all_favourites(current_user)
    @owned = TaskRelation.all_owned(current_user)
  end

  def show
    @task_relation = TaskRelation.find(params[:id])

    throw ActiveRecord::RecordNotFound unless @task_relation.visible_to(current_user)

    @task_relation
  end

  def new
    @tasks = tasks(params)

    render "create"
  end

  def tasks(params)
    return params&.[]('tasks') || []
  end

  def create
    @tasks = tasks(params)

    return case params&.[]('commit')
    when 'Adicionar tarefa'
      @tasks << ""
    when /^Remover (\d+)ª tarefa$/
      ordinal = ($1).to_i
      @tasks.slice! ordinal - 1
      flash.notice = "Tarefa N.º #{ordinal} removida."
    else
    # ActiveRecord::Base.transaction do
      @task_relation = TaskRelation.new({ user: current_user })
      @task_relation.public = params&.[]('public') == "1"
      @tasks.each do |description|
        @task_relation.tasks.build({ description: description })
      end
      @task_relation.save!
    # end

      flash.notice = 'Lista de tarefa salva.'

      redirect_to @task_relation
    end
  end

  def favourite!
    task_relation = TaskRelation.find(params['id'])
    user = current_user
    throw ActiveRecord::RecordNotFound unless task_relation.visible_to(user)

    favourite = Favourite.new(user: user, task_relation: task_relation )
    if favourite.valid?
      favourite.save!
      flash.notice = 'Lista de tarefa marcada como favorita.'
    end

    redirect_to task_relations_path
  end
end

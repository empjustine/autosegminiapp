class TasksController < ApplicationController
  before_action :authenticate_user!

  layout "application"

  def close!
    @task = Task.find(params['id'])

    @task.close!(current_user)

    flash.notice = "Tarefa concluída."

    redirect_to @task.task_relation
  end
end
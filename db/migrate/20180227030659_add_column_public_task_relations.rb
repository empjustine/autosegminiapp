class AddColumnPublicTaskRelations < ActiveRecord::Migration[5.1]
  def change
    add_column :task_relations, :public, :boolean
  end
end

class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.references :task_relation, foreign_key: true

      t.timestamps
    end
  end
end

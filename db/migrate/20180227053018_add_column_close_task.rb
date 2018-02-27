class AddColumnCloseTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :closed, :boolean
  end
end

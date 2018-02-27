class AddFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.references :task_relation, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

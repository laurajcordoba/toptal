class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :priority
      t.datetime :due_date
      t.boolean :completed

      t.timestamps
    end
  end
end

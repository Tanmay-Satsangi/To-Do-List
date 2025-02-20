class CreateTask < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.text :task
      t.timestamps
    end
  end
end

class AddPriorityColumnToTask < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :priority, :string
    remove_column :tasks, :status
  end
end

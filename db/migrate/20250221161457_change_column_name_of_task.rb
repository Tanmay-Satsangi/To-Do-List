class ChangeColumnNameOfTask < ActiveRecord::Migration[7.2]
  def change
    rename_column :tasks, :task, :title
  end
end

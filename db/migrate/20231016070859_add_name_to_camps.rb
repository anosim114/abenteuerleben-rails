class AddNameToCamps < ActiveRecord::Migration[7.0]
  def change
    add_column :camps, :name, :string
  end
end

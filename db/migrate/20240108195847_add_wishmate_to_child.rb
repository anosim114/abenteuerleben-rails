class AddWishmateToChild < ActiveRecord::Migration[7.1]
  def change
    add_column :children, :wishmate, :string
  end
end

class AddPriceToCamp < ActiveRecord::Migration[7.1]
  def change
    add_column :camps, :price, :integer
  end
end

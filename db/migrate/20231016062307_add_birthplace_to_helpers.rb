class AddBirthplaceToHelpers < ActiveRecord::Migration[7.0]
  def change
    add_column :helpers, :birthplace, :string
  end
end

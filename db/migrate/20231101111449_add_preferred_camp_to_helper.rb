class AddPreferredCampToHelper < ActiveRecord::Migration[7.1]
  def change
    add_column :helpers, :preferredCamp, :string
  end
end

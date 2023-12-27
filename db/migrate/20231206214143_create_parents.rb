class CreateParents < ActiveRecord::Migration[7.1]
  def change
    create_table :parents do |t|
      t.string :surname
      t.string :forename
      t.string :telephone
      t.string :housephone
      t.string :email
      t.string :street
      t.string :house
      t.string :post
      t.string :city
      t.boolean :member
      t.string :church

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_hash
      t.integer :level
      t.string :email

      t.timestamps
    end
  end
end

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.text :message
      t.boolean :read

      t.timestamps
    end
  end
end

class CreateHelpers < ActiveRecord::Migration[7.0]
  def change
    create_table :helpers do |t|
      t.string :surname, null: false
      t.string :forename, null: false
      t.date :birthday, null: false
      t.string :telephone, null: false
      t.string :email, null: false
      t.string :streethouse, null: false
      t.string :postcity, null: false
      t.text :story, null: false
      t.string :duty

      t.timestamps
    end
  end
end

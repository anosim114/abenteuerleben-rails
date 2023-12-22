class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :surname
      t.string :forename
      t.date :birthday
      t.string :sex
      t.string :medicals
      t.string :notes
      t.references :parent, null: false, foreign_key: true
      t.references :camp, null: false, foreign_key: true

      t.timestamps
    end
  end
end

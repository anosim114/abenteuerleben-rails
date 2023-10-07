class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :helper, null: false, foreign_key: true
      t.references :camp, null: false, foreign_key: true
      t.string :wish_first, null: false
      t.string :wish_second, null: false
      t.boolean :participate

      t.timestamps
    end
  end
end

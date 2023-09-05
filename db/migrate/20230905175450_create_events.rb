class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.date :start, null: false
      t.date :end
      t.string :link

      t.timestamps
    end
  end
end

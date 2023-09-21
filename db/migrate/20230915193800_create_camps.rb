class CreateCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :camps do |t|
      t.references :campyear, null: false, foreign_key: true
      t.date :date_start
      t.date :date_end
      t.integer :participants_year_start
      t.integer :participants_year_end
      t.integer :max_participant_count

      t.timestamps
    end
  end
end

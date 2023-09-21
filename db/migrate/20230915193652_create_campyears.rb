class CreateCampyears < ActiveRecord::Migration[7.0]
  def change
    create_table :campyears do |t|
      t.integer :year
      t.date :participants_register_start
      t.date :participants_register_end
      t.date :helper_register_start
      t.date :helper_register_end
      t.string :accentcolor_primary
      t.string :accentcolor_secondary

      t.timestamps
    end
  end
end

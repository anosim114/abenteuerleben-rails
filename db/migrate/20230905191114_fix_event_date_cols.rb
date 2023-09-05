class FixEventDateCols < ActiveRecord::Migration[7.0]
    def self.up
      rename_column :events, :start, :start_date
      rename_column :events, :end, :end_date
    end

    def self.down
      rename_column :events, :start_date, :start
      rename_column :events, :end_date, :end
    end
end

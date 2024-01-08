class FixCampyearsMembersOnlyStart < ActiveRecord::Migration[7.1]
  def change
    Campyear.all do |year|
      year.members_only_start = year.participants_register_start
      year.save
    end
  end
end

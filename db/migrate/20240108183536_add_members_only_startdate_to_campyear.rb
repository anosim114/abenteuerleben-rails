class AddMembersOnlyStartdateToCampyear < ActiveRecord::Migration[7.1]
  def change
    add_column :campyears, :members_only_start, :date

    Campyear.all do |year|
      year.members_only_start = year.participants_register_start
    end
  end
end

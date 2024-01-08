class AddMembersOnlyStartdateToCampyear < ActiveRecord::Migration[7.1]
  def change
    add_column :campyears, :members_only_start, :date
  end
end

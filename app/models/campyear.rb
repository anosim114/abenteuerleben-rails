class Campyear < ApplicationRecord
  has_many :camps, dependent: :destroy

  validate :participant_member_date_earlier_all_date

  def participant_member_date_earlier_all_date
    return if participants_register_start >= members_only_start

    errors.add :members_only_date, 'muss gleich oder früher als der Start aller sein'
  end

  def full?
    camps.filter(&:not_full?).empty?
  end

  def open_camps
    camps.filter(&:not_full?)
  end
end

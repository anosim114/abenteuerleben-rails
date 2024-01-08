class Campyear < ApplicationRecord
  has_many :camps, dependent: :destroy

  validates :participants_register_start, presence: true
  validates :members_only_start, presence: true
  validates :participants_register_end, presence: true

  validate :participant_member_date_earlier_all_date

  def participant_member_date_earlier_all_date
    if !(participants_register_start.nil? || members_only_start.nil?) &&
       participants_register_start >= members_only_start
      return
    end

    errors.add :members_only_date, 'muss gleich oder früher als der Start aller sein'
  end

  def full?
    camps.filter(&:not_full?).empty?
  end

  def open_camps
    camps.filter(&:not_full?)
  end
end

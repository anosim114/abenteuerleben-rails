class Campyear < ApplicationRecord
  has_many :camps, dependent: :destroy

  def full?
    camps.filter(&:not_full?).empty?
  end

  def open_camps
    camps.filter(&:not_full?)
  end
end

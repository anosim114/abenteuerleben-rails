class Camp < ApplicationRecord
  belongs_to :campyear
  has_many :registrations, dependent: :destroy
  has_many :children, dependent: :destroy

  validates :date_start, presence: true
  validates :date_end, presence: true
  validates :participants_year_start, presence: true
  validates :participants_year_end, presence: true
  validates :max_participant_count, presence: true
  validates :price, presence: true
  validates :campyear, presence: true

  def open_count
    max_participant_count - children.length
  end

  def full?
    max_participant_count <= children.length
  end

  def not_full?
    !full?
  end
end

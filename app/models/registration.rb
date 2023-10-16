class Registration < ApplicationRecord
  belongs_to :helper
  belongs_to :camp

  validates :wish_first, presence: true
  validates :wish_second, presence: true

  attr_accessor :wish_first_box, :wish_second_box

  def self.team_free_value
    "Sonstiges"
  end
end

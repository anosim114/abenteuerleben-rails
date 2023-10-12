class Registration < ApplicationRecord
  belongs_to :helper
  belongs_to :camp

  attr_accessor :wish_first_box, :wish_second_box

  def self.team_free_value
    "_Andere/Sonstiges"
  end
end

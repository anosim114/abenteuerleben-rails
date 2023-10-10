class Registration < ApplicationRecord
  belongs_to :helper
  belongs_to :camp

  def self.team_free_value
    "Anderes"
  end
end

class Campyear < ApplicationRecord
  has_many :camps, dependent: :destroy
end

class Camp < ApplicationRecord
  belongs_to :campyear
  has_many :registrations, dependent: :destroy
end

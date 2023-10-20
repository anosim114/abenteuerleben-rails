class Download < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true

  has_one_attached :file
end

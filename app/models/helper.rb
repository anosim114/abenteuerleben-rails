class Helper < ApplicationRecord
  has_many :registrations, dependent: :destroy
  accepts_nested_attributes_for :registrations

  validates :surname, presence: true
  validates :forename, presence: true
  validates :birthday, presence: true
  validates :telephone, presence: true
  validates :email, presence: true
  validates :streethouse, presence: true
  validates :postcity, presence: true
  validates :story, presence: true
  # todo: validation that at least one registration is there
end

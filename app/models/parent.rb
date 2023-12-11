class Parent < ApplicationRecord
  # base
  validates :surname, presence: true, on: :base
  validates :forename, presence: true, on: :base

  # address
  validates :street, presence: true, on: :address
  validates :house, presence: true, on: :address
  validates :post, presence: true, on: :address
  validates :city, presence: true, on: :address

  # contact
  validates :telephone, presence: true, on: :contact
  validates :housephone, presence: true, on: :contact
  validates :email, presence: true, on: :contact

  # optional
  validates :church, presence: true, on: :optional # based on if member or not
end

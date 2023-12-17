class Parent < ApplicationRecord
  # base
  validates :surname, presence: true, on: %i[base create]
  validates :forename, presence: true, on: %i[base create]

  # address
  validates :street, presence: true, on: %i[address create]
  validates :house, presence: true, on: %i[address create]
  validates :post, presence: true, on: %i[address create]
  validates :city, presence: true, on: %i[address create]

  # contact
  validates :telephone, presence: true, on: %i[contact create]
  validates :email, presence: true, on: %i[contact create]

  validates :child_count, presence: true, on: %i[child_count create]

  # optional
  validate :validate_church, on: %i[optional create] # based on if member or not

  attr_accessor :child_count

  def validate_church
    return if member || church.present?

    errors.add :church, 'Trage bitte deine zugehörige Kirche ein'
  end
end


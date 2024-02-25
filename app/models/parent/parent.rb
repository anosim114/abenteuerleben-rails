module Parent
  class Parent < ApplicationRecord
    has_many :children

    # base
    validates :surname, presence: true
    validates :forename, presence: true

    # address
    validates :street, presence: true
    validates :house, presence: true
    validates :post, presence: true
    validates :city, presence: true

    # contact
    validates :telephone, presence: true
    validates :email, presence: true
  end
end

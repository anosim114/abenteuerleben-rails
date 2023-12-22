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

      # church
      validate :needs_church # based on if member or not

      def needs_church
        return if member || church.present?

        errors.add :church, 'Trage bitte deine zugehörige Kirche ein'
      end
    end
end

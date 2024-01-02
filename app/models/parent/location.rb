module Parent
  class Location
    include ActiveModel::Model

    attr_accessor :street, :house, :post, :city

    validates :street, presence: true
    validates :house, presence: true
    validates :post, presence: true
    validates :city, presence: true
  end
end

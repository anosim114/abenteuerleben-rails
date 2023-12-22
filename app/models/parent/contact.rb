module Parent
    class Contact
        include ActiveModel::Model

        attr_accessor :telephone, :housephone, :email

        validates :telephone, presence: true
        validates :email, presence: true
    end
end

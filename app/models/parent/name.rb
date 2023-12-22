module Parent
    class Name
        include ActiveModel::Model

        attr_accessor :surname, :forename, :member

        validates :surname, presence: true
        validates :forename, presence: true
    end
end

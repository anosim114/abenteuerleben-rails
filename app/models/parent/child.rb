module Parent
    class Child
        include ActiveModel::Model

        attr_accessor :count

        validates :count, presence: true
    end
end

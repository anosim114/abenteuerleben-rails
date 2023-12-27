module Parent
  class Name
    include ActiveModel::Model

    attr_accessor :surname, :forename, :member

    validates :surname, presence: true
    validates :forename, presence: true

    # church
    validate :non_member_permit

    def non_member_permit
      # TODO: check if other chruches are allowed to register
      return if member == '1'

      errors.add :member, 'Bis zum xx.yy.zzzz ist die Anmeldung nur für FECG Blomberg Mitglieder freigegeben'
    end
  end
end

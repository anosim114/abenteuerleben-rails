module Parent
  class Name
    include ActiveModel::Model

    attr_accessor :surname, :forename, :member

    validates :surname, presence: true
    validates :forename, presence: true

    # church
    validate :non_member_permit

    def non_member_permit
      return if member

      participants_register_start = ApplicationController.helpers.active_campyear.participants_register_start
      return if Time.zone.today >= participants_register_start

      errors.add :member,
                 "Bis zum #{I18n.localize participants_register_start} ist die Anmeldung
                  nur für FECG Blomberg Mitglieder freigegeben"
    end
  end
end

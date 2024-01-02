# frozen_string_literal: true

module CampyearsHelper
  def get_active_campyear
    active_campyear
  end

  def active_campyear
    Campyear.last!
  end

  def participant_registrations_open
    cy = get_active_campyear
    bigger_than_start = Time.zone.today >= cy.members_only_start || Date.now >= cy.participants_register_start
    smaller_than_end = Time.zone.today <= cy.participants_register_end

    bigger_than_start && smaller_than_end
  end
end

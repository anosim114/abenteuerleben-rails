# frozen_string_literal: true

module CampyearsHelper
  def get_active_campyear
    Campyear.last!
  end
end

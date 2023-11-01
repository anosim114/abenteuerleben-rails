class HomeController < ApplicationController
  def index
    campyear = helpers.get_active_campyear
    @helpers_open =
      DateTime.now > campyear.helper_register_start &&
      DateTime.now < campyear.helper_register_end

    @participants_open =
    DateTime.now > campyear.participants_register_start &&
      DateTime.now < campyear.participants_register_end

    @events = Event.where(["start_date >= ? OR end_date >= ?", Date.today, Date.today]).order('start_date ASC')
    @message = Message.new
  end
end

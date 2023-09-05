class HomeController < ApplicationController
  def index
    @events = Event.where(["start_date >= ? OR end_date NOT NULL AND end_date > ?", Date.today, Date.today]).order('start_date ASC')
    @message = Message.new
  end
end

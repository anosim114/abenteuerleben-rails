class HomeController < ApplicationController
  def index
    @events = Event.where(["start >= ? OR end NOT NULL AND end > ?", Date.today, Date.today]).order('start ASC')
    @message = Message.new
  end
end

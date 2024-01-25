class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :admin_only

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_url(@event), notice: "Termin erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_url(@event), notice: "Termin erfolgreich geändert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to events_url, notice: "Termin erfolgreich gelöscht."
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date, :link)
  end
end

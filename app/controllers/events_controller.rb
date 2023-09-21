class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :admin_only

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_url(@event), notice: "Termin erfolgreich erstellt."
      render :show, status: :created, location: @event
    else
      render :new, status: :unprocessable_entity
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    if @event.update(event_params)
      redirect_to event_url(@event), notice: "Termin erfolgreich geändert."
      render :show, status: :ok, location: @event
    else
      render :edit, status: :unprocessable_entity
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

     redirect_to events_url, notice: "Termin erfolgreich gelöscht."
     head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date, :link)
    end
end

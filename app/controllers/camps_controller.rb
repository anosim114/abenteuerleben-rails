class CampsController < ApplicationController
  before_action :set_camp, only: %i[ show edit update destroy ]

  # GET /camps or /camps.json
  def index
    @camps = Camp.all
  end

  # GET /camps/1 or /camps/1.json
  def show
  end

  # GET /camps/new
  def new
    if params[:campyear] == nil or Campyear.where(id: params[:campyear]).empty?
      redirect_to campyears_path
      return
    end

    @camp = Camp.new
    @camp.campyear = Campyear.find params[:campyear]
  end

  # GET /camps/1/edit
  def edit
  end

  # POST /camps or /camps.json
  def create
    @camp = Camp.new(camp_params)

    if @camp.save
      redirect_to camp_url(@camp), notice: "Camp erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /camps/1 or /camps/1.json
  def update
    if @camp.update(camp_params)
      redirect_to camp_url(@camp), notice: "Camp erfolgreich geändert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /camps/1 or /camps/1.json
  def destroy
    @camp.destroy

      redirect_to camps_url, notice: "Camp erfolgreich gelöscht."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camp_params
      params.require(:camp).permit(:campyear_id, :date_start, :date_end, :participants_year_start, :participants_year_end, :max_participant_count)
    end
end

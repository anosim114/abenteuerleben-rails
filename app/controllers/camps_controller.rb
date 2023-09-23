class CampsController < ApplicationController
  before_action :set_campyear, except: %i[ index ]
  before_action :set_camp, only: %i[ show edit update destroy ]
  before_action :admin_only

  # GET /camps or /camps.json
  def index
    @camps = Camp.all
  end

  # GET /camps/1 or /camps/1.json
  def show
  end

  # GET /camps/new
  def new
    @camp = Camp.new
    @camp.campyear = @campyear
  end

  # GET /camps/1/edit
  def edit
  end

  # POST /camps or /camps.json
  def create
    @camp = Camp.new(camp_params)

    if @camp.save
      redirect_to campyear_camp_url(@campyear, @camp), notice: "Camp erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /camps/1 or /camps/1.json
  def update
    if @camp.update(camp_params)
      redirect_to campyear_camp_url(@campyear, @camp), notice: "Camp erfolgreich geändert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /camps/1 or /camps/1.json
  def destroy
    campyear_id = @camp.campyear_id
    @camp.destroy

    redirect_to campyear_path(campyear_id), notice: "Camp erfolgreich gelöscht."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def set_campyear
      doesExist = Campyear.exists?(params[:campyear_id])
      unless doesExist
        redirect_to campyears_path
        return
      end

      @campyear = Campyear.find(params[:campyear_id])
    end

    # Only allow a list of trusted parameters through.
    def camp_params
      params.require(:camp).permit(:campyear_id, :date_start, :date_end, :participants_year_start, :participants_year_end, :max_participant_count)
    end
end

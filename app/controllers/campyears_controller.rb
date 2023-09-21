class CampyearsController < ApplicationController
  before_action :set_campyear, only: %i[ show edit update destroy ]

  # GET /campyears or /campyears.json
  def index
    @campyears = Campyear.all
  end

  # GET /campyears/1 or /campyears/1.json
  def show
    @camps = Camp.where campyear: @campyear.id
  end

  # GET /campyears/new
  def new
    @campyear = Campyear.new
  end

  # GET /campyears/1/edit
  def edit
  end

  # POST /campyears or /campyears.json
  def create
    @campyear = Campyear.new(campyear_params)

    if @campyear.save
      redirect_to campyear_url(@campyear), notice: "Campyear was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campyears/1 or /campyears/1.json
  def update
    if @campyear.update(campyear_params)
      redirect_to campyear_url(@campyear), notice: "Campyear was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /campyears/1 or /campyears/1.json
  def destroy
    @campyear.destroy

    redirect_to campyears_url, notice: "Campyear was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campyear
      @campyear = Campyear.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campyear_params
      params.require(:campyear).permit(:year, :participants_register_start, :participants_register_end, :helper_register_start, :helper_register_end, :accentcolor_primary, :accentcolor_secondary)
    end
end

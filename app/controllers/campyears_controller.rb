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

    respond_to do |format|
      if @campyear.save
        format.html { redirect_to campyear_url(@campyear), notice: "Campyear was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campyears/1 or /campyears/1.json
  def update
    respond_to do |format|
      if @campyear.update(campyear_params)
        format.html { redirect_to campyear_url(@campyear), notice: "Campyear was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campyears/1 or /campyears/1.json
  def destroy
    @campyear.destroy

    respond_to do |format|
      format.html { redirect_to campyears_url, notice: "Campyear was successfully destroyed." }
    end
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

class CampsController < ApplicationController
  before_action :admin_only
  before_action :set_camp, except: %i[index new create]
  before_action :set_campyear, only: %i[index edit show new create]

  add_breadcrumb helpers.t('admin.dashboard.title'), :admin_dashboard_path
  add_breadcrumb 'Campjahre', :campyears_path

  def index
    @camps = Camp.all
  end

  def show; end

  def new
    @camp = Camp.new
    @camp.campyear = @campyear
  end

  def edit
    add_breadcrumb @campyear.year, campyear_path(@campyear)
    add_breadcrumb @camp.name, edit_camp_path(@camp)
  end

  def create
    @camp = Camp.new(camp_params)

    if @camp.save
      redirect_to camp_path(@camp), notice: 'Camp erfolgreich erstellt.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @camp.update(camp_params)
      redirect_to camp_path(@camp), notice: 'Camp erfolgreich geändert.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    campyear_id = @camp.campyear_id
    @camp.destroy

    redirect_to campyear_path(campyear_id), notice: 'Camp erfolgreich gelöscht.'
  end

  private
  def add_campyear_breadcrumb
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_camp
    @camp = Camp.find(params[:id])
  end

  def set_campyear
    if @camp.id
      @campyear = @camp.campyear
      return
    end

    does_exist = Campyear.exists?(params[:campyear_id])
    unless does_exist
      redirect_to campyears_path
      return
    end

    @campyear = Campyear.find(params[:campyear_id])
  end

  # Only allow a list of trusted parameters through.
  def camp_params
    params
      .require(:camp)
      .permit(
        :campyear_id,
        :name,
        :date_start,
        :date_end,
        :participants_year_start,
        :participants_year_end,
        :max_participant_count,
        :price
      )
  end
end

class CampyearsController < ApplicationController
  before_action :set_campyear, only: %i[show edit update destroy]
  before_action :admin_only

  add_breadcrumb helpers.t('admin.dashboard.title'), :admin_dashboard_path
  add_breadcrumb 'Campjahre', :campyears_path

  def index
    @campyears = Campyear.all
  end

  def show
    @camps = Camp.where campyear: @campyear.id
    add_breadcrumb @campyear.year, campyear_path(@campyear)
  end

  def new
    @campyear = Campyear.new
  end

  def edit; end

  def create
    @campyear = Campyear.new(campyear_params)

    if @campyear.save
      redirect_to campyear_url(@campyear), notice: 'Campjahr erfolgreich erstellt.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @campyear.update(campyear_params)
      redirect_to campyear_url(@campyear), notice: 'Campjahr erfolgreich geändert.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @campyear.destroy

    redirect_to campyears_url, notice: 'Campjahr erfolgreich gelöscht.'
  end

  private

  def set_campyear
    @campyear = Campyear.find(params[:id])
  end

  def campyear_params
    params.require(:campyear).permit(
      :year,
      :members_only_start,
      :participants_register_start,
      :participants_register_end,
      :helper_register_start,
      :helper_register_end,
      :accentcolor_primary,
      :accentcolor_secondary
    )
  end
end

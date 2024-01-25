class HelpersController < ApplicationController # rubocop:disable Metrics/ClassLength
  before_action :admin_only, except: %i[new create]
  before_action :set_active_camps, only: %i[new create edit update]
  before_action :set_available_teams, only: %i[new create edit update]
  before_action :set_helper, only: %i[show edit update destroy]

  add_breadcrumb helpers.t('admin.dashboard.title'), :admin_dashboard_path
  add_breadcrumb 'Mitarbeiter', :helpers_path

  def index
    @year = params[:year].to_i != 0 ? params[:year].to_i : helpers.get_active_campyear.year

    @helpers = Helper
               .joins(registrations: { camp: :campyear })
               .where('campyears.year': @year)
               .order(:surname)
               .distinct

    @campyears = Campyear.all.order(year: :desc).map(&:year)
  end

  # GET /helpers/1 or /helpers/1.json
  def show; end

  # GET /helpers/new
  def new
    @helper = Helper.new

    @camps.each do |camp|
      @helper.registrations.build(
        camp_id: camp.id,
        wish_first: @available_teams.first,
        wish_second: @available_teams.second
      )
    end
  end

  def edit; end

  # POST /helpers or /helpers.json
  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    # save helper
    @helper = Helper.new(helper_params)

    if @helper.valid?
      # remove registrations which are not to participate
      @helper.registrations = @helper.registrations.filter(&:participate)

      @helper.save
      HelperMailer.with(helper: @helper).registered_mail.deliver_later
      redirect_to root_path, notice: 'Erfolgreich als Mitarbeiter angemeldet.'
    else
      @helper.registrations.each do |r|
        unless @available_teams.include? r.wish_first
          r.wish_first_box = r.wish_first
          r.wish_first = Registration.team_free_value
        end

        unless @available_teams.include? r.wish_second
          r.wish_second_box = r.wish_second
          r.wish_second = Registration.team_free_value
        end
      end

      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /helpers/1 or /helpers/1.json
  def update
    if @helper.update(helper_params_update)
      redirect_to helper_url(@helper), notice: 'Mitarbeiter erfolgreich geändert.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /helpers/1 or /helpers/1.json
  def destroy
    @helper.destroy

    redirect_to helpers_url, notice: 'Mitarbeiter erfolgreich gelöscht.'
  end

  def excelify
    active_campyear = helpers.get_active_campyear
    @helpers = Helper.select('*').joins(registrations: [{ camp: :campyear }]).where('campyears.id' => active_campyear.id)

    respond_to do |format|
      format.xlsx
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_helper
    @helper = Helper.find(params[:id])
  end

  def set_available_teams
    @teams = Team.where(enabled: true).order(:name)
    @available_teams = @teams.map { |team| team.name }
  end

  def set_active_camps
    @camps = helpers.get_active_campyear.camps
  end

  # Only allow a list of trusted parameters through.
  def helper_params
    params.require(:helper).permit(
      :photo,
      :surname, :forename, :birthday, :birthplace, :telephone, :email,
      :streethouse, :postcity,
      :story, :duty,
      :important_information, :liability_exclusion,
      :preferredCamp,
      registrations_attributes: %i[id camp_id wish_first wish_second participate]
    )
  end

  def helper_params_update
    params.require(:helper).permit(
      :surname, :forename, :birthday, :birthplace, :telephone, :email,
      :streethouse, :postcity,
      :story, :duty,
      :important_information, :liability_exclusion
    )
  end

  def new_registrations
    registrations = []

    @camps.each do |camp|
      registrations << Registration.new(
        id: camp.id,
        wish_first: Team.first.name,
        wish_second: Team.second.name,
        camp:,
        participate: false,
        helper: @helper
      )
    end

    registrations
  end

  def get_registrations(helper_params)
    registrations = []
    return [new_registrations] * 2 if helper_params[:registration].nil?

    register_params = helper_params[:registration]

    @camps.each do |camp|
      wants_to_participate = register_params[camp.id.to_s][:participate].to_i == 1

      registrations << Registration.new(
        id: camp.id.to_s,
        wish_first: register_params[camp.id.to_s][:wish_first],
        wish_second: register_params[camp.id.to_s][:wish_second],
        participate: wants_to_participate,
        camp_id: camp.id.to_s
      )
    end

    registrations
  end
end

class HelpersController < ApplicationController
  before_action :admin_only, except: %i[ new create ]
  before_action :set_active_camps, only: %i[ new create edit update ]
  before_action :set_available_teams, only: %i[ new create edit update ]
  before_action :set_helper, only: %i[ show edit update destroy ]

  # GET /helpers or /helpers.json
  def index
    @helpers = Helper.all.order(:surname)
  end

  # GET /helpers/1 or /helpers/1.json
  def show
  end

  # GET /helpers/new
  def new
    @helper = Helper.new
    registrations = []
    @available_teams

    @camps.each do |camp|
      @helper.registrations << new_registration(@helper, camp)
    end
  end

  def edit
  end

  # POST /helpers or /helpers.json
  def create
    register_params = helper_params[:registration]
    logger.info "New attempted Helper registration: #{helper_params.inspect}"

    registrations = []

    @camps.each do |camp|
      wants_to_participate = register_params[camp.id.to_s][:participate].to_i == 1

      registrations << Registration.new(
        wish_first: register_params[camp.id.to_s][:wish_first],
        wish_second: register_params[camp.id.to_s][:wish_second],
        participate: wants_to_participate,
        camp_id: camp.id.to_s
      )
    end

    # save helper
    @helper = Helper.new(
      surname: helper_params[:surname],
      forename: helper_params[:forename],
      birthday: helper_params[:year] + '-' + helper_params[:month] + '-' + helper_params[:day],
      telephone: helper_params[:telephone],
      email: helper_params[:email],
      streethouse: helper_params[:streethouse],
      postcity: helper_params[:postcity],
      story: helper_params[:story],
      duty: helper_params[:duty]
    )

    # todo: check if I can add the registrations to helper and have them both be saved at the same time
    if @helper.save
      # save registratios
      # - assign helper id
      # - hit save
      registrations.each do |r|

        if not r.participate
          next
        end

        r.helper_id = @helper.id
        r.save
      end

      logger.info "Registration successful for: #{@helper.surname}"
      redirect_to root_path, notice: "Erfolgreich als Mitarbeiter angemeldet."
    else
      logger.info "Registration failed for: #{@helper.surname}"
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /helpers/1 or /helpers/1.json
  def update
    if @helper.update(helper_params)
      redirect_to helper_url(@helper), notice: "Mitarbeiter erfolgreich geändert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /helpers/1 or /helpers/1.json
  def destroy
    @helper.destroy

    redirect_to helpers_url, notice: "Mitarbeiter erfolgreich gelöscht."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_helper
      @helper = Helper.find(params[:id])
    end

    def set_available_teams
      @available_teams = Team.where(enabled: true).order(:name).map{ |team| team.name }
      @available_teams << "Anderes"
    end

    def set_active_camps
      @campyear =
      @camps = Campyear.last.camps
    end

    # Only allow a list of trusted parameters through.
    def helper_params
      params.require(:helper).permit(
        :surname, :forename, :year, :month, :day, :telephone, :email, :streethouse, :postcity, :story, :duty,
        { registration: [:wish_first, :wish_second, :participate] }
      )
    end

    def new_registration helper, camp
      registration = Registration.new
      registration.id = camp.id
      registration.wish_first = Team.first.name
      registration.wish_second = Team.second.name
      registration.camp = camp
      registration.helper = helper
      registration
    end
end

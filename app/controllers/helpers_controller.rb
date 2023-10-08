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

    @camps.each do |camp|
      @helper.registrations.build(
        camp_id: camp.id,
        wish_first: @available_teams.first,
        wish_second: @available_teams.second
      )
    end
  end

  def edit
  end

  # POST /helpers or /helpers.json
  def create
    # save helper
    @helper = Helper.new(helper_params)

    if @helper.save
      # remove registrations which are not to participate
      @helper.registrations.each do |r|
        if r.participate
          next
        end

        r.destroy
      end

      redirect_to root_path, notice: "Erfolgreich als Mitarbeiter angemeldet."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /helpers/1 or /helpers/1.json
  def update
    if @helper.update(helper_params_update)
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
      @camps = Campyear.last.camps
    end

    # Only allow a list of trusted parameters through.
    def helper_params
      params.require(:helper).permit(
        :surname, :forename, :birthday, :telephone, :email, :streethouse, :postcity, :story, :duty,
        registrations_attributes: [ :camp_id, :wish_first, :wish_second, :participate ]
      )
    end

    def helper_params_update
      params.require(:helper).permit(
        :surname, :forename, :birthday, :telephone, :email, :streethouse, :postcity, :story, :duty
      )
    end

    def new_registrations
      registrations = []

      @camps.each do |camp|
        registrations << Registration.new(
          id: camp.id,
          wish_first: Team.first.name,
          wish_second: Team.second.name,
          camp: camp,
          participate: false,
          helper: @helper
        )
      end

      registrations
    end

    def get_registrations helper_params
      registrations = []
      if helper_params[:registration] == nil
        return [new_registrations] * 2
      end

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

class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]
  before_action :admin_only, except: %i[ catalogue ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all.order(:name)
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
    @team.enabled = true
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to team_url(@team), notice: "Team erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    if @team.update(team_params)
      redirect_to team_url(@team), notice: "Team erfolgreich gespeichert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    redirect_to teams_url, notice: "Team erfolgreich gelöscht."
  end

  def catalogue
    logger.debug 'going to render the team catalogue'
    team_params = params.permit(:id)

    @selected_team = Team.find(team_params[:id])
    @teams = Team.where(enabled: true).order(:name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :description, :enabled)
    end
end

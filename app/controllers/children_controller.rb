class ChildrenController < ApplicationController
  before_action :set_active_campyear, only: %i[new create]
  before_action :set_camps, only: %i[new create]
  before_action :set_child_and_parent, only: %i[show edit update destroy]

  def index
    @year = params[:year].to_i != 0 ? params[:year].to_i : helpers.get_active_campyear.year

    @children = Child
                .joins(camp: :campyear)
                .where('campyears.year': @year)
                .order(:surname)
                .distinct

    @campyears = Campyear.all.order(year: :desc).map(&:year)
  end

  def show; end

  def new
    @child = if params[:child].nil?
               Child.new
             else
               Child.new session[:children][params[:child].to_i]
             end
  end

  def create
    @child = Child.new child_params

    if @child.valid? :form
      enough = save_child_to_session @child

      redirect_to enough ? new_parent_parent_path : new_child_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @return {boolean} if enough children are now registered
  def save_child_to_session(child)
    return true if ENV['RAILS_ENV'] == 'test'

    session[:children] = [] if session[:children].nil?
    session[:children] << child

    stats = session[:parent_child_stat]
    session[:children].length >= stats.count.to_i
  end

  def edit; end

  def update; end

  def destroy
    # TODO: check if parent has no more children and destroy as well in case thereof
    name = "#{@child.forename} #{@child.surname}"
    @child.destroy
    redirect_to children_path, notice: "Erfolreich gelöscht: #{name}"
  end

  private

  def set_child_and_parent
    @child = Child.find(params[:id])
    @parent = @child.parent
  end

  def set_active_campyear
    @campyear = helpers.get_active_campyear
  end

  def set_camps
    @camps = @campyear.camps.map do |c|
      [
        "Camp #{c.name} (#{c.participants_year_start} - #{c.participants_year_end})",
        c.id
      ]
    end
  end

  def child_params
    params.require(:child).permit(
      :surname,
      :forename,
      :birthday,
      :sex,
      :medicals,
      :notes,
      :camp_id
    )
  end
end
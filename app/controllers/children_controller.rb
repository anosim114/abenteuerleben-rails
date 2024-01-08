class ChildrenController < ApplicationController
  before_action :set_active_campyear, only: %i[new create]
  before_action :set_camps, only: %i[new create]
  before_action :set_child_and_parent, only: %i[show edit update destroy]
  before_action :set_child_num, only: %i[new create]

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
    @child = if session[:children].nil?
               Child.new
             else
               Child.new session[:children][params[:child_num].to_i]
             end
  end

  def create
    @child = Child.new child_params

    if @child.valid? :form
      save_child_to_session @child

      next_child_num = @child_num + 1
      redirect_route = enough? ? new_parent_parent_path : new_child_path(child_num: next_child_num)
      redirect_to redirect_route
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @return {boolean} if enough children are now registered
  def save_child_to_session(child)
    return if ENV['RAILS_ENV'] == 'test'

    session[:children] = [] if session[:children].nil?
    session[:children][@child_num] = child
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

  def enough?
    return false if session[:children].nil?

    session_child_count = session[:children].length
    session_child_stat_count = session[:parent_child_stat]['count'].to_i

    session_child_count >= session_child_stat_count
  end

  def set_child_num
    param_str = params[:child_num]

    @child_num = param_str.nil? ? 0 : param_str.to_i
  end

  def set_child_and_parent
    @child = Child.find(params[:id])
    @parent = @child.parent
  end

  def set_active_campyear
    @campyear = helpers.get_active_campyear
  end

  def set_camps
    @camps = @campyear.open_camps.map do |c|
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
      :wishmate,
      :camp_id
    )
  end
end

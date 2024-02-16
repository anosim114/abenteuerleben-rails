class ChildrenController < ApplicationController
  before_action :set_active_campyear, only: %i[new create edit update]
  before_action :set_camps, only: %i[new create edit update]
  before_action :set_child_and_parent, only: %i[show edit update destroy]
  before_action :set_child_num, only: %i[new create]

  add_breadcrumb helpers.t('admin.dashboard.title'), :admin_dashboard_path
  add_breadcrumb 'Kinder', :children_path

  def index
    @year = (params[:year] || helpers.get_active_campyear.year).to_i
    @campyears = Campyear.all.order(year: :desc).map(&:year)
    @children = Child.from_year @year
  end

  def show
    add_breadcrumb "#{@child.surname}, #{@child.forename}", child_path(@child)
  end

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

      redirect_route = if enough?
                         new_parent_parent_path
                       else
                         new_child_path(child_num: @child_num + 1)
                       end
      redirect_to redirect_route
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @return {boolean} if enough children are now registered
  def save_child_to_session(child)
    session[:children] = [] if session[:children].nil?
    session[:children][@child_num] = child
  end

  def edit
    add_breadcrumb "#{@child.surname}, #{@child.forename}", child_path(@child)
    add_breadcrumb "Ändern", edit_child_path(@child)
  end

  def update
    add_breadcrumb "#{@child.surname}, #{@child.forename}", child_path(@child)
    add_breadcrumb "Ändern", edit_child_path(@child)

    if @child.update(child_params)
      redirect_to child_path(@child)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # TODO: check if parent has no more children and destroy as well in case thereof
    name = "#{@child.forename} #{@child.surname}"
    parent_id = @child.parent.id

    @child.destroy

    parent = Parent::Parent.find parent_id
    if parent.children.length == 0
      parent.destroy
    end

    redirect_to children_path, notice: "Erfolreich gelöscht: #{name}"
  end

  private

  def enough?
    return false if session[:children].nil?

    session_child_count = session[:children].length

    return false unless session[:parent_child_stat]

    session_child_stat_count = session[:parent_child_stat]['count'].to_i

    session_child_count >= session_child_stat_count
  end

  def set_child_num
    @child_num = (params[:child_num] || 0).to_i
  end

  def set_child_and_parent
    @child = Child.find(params[:id])
    @parent = @child.parent
  end

  def set_active_campyear
    @campyear = helpers.get_active_campyear
  end

  def set_camps
    @camps = @campyear.camps
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

class ChildrenController < ApplicationController
  before_action :set_active_campyear, only: %i[new create edit update]
  before_action :set_camps, only: %i[new create]

  def index
  end

  def show
  end

  def new
    @child = Child.new
  end

  def create
    @child = Child.new child_params

    if @child.valid? :form
      session[:children] = [] if session[:children].nil?

      session[:children] << @child

      redirect_to new_parent_parent_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

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
    logger.debug @camps.to_json
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

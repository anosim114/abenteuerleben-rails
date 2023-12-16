class ChildRegistrationsController < ApplicationController
  before_action :set_parent, only: %i[create acknowledge]

  def index
    # show camp info and the registration button
  end

  def new
    @parent = Parent.new
    @stage = 'base'
  end

  def create
    stage = 'base'
    if params[:back]
      previous = params[:last_stage]
      previous = 'base' if previous == 'optional' && @parent.member
      stage = previous
    else
      # if direction is forward, get next stage
      stage = next_stage params[:stage]
    end

    @stage = stage
    render :new
  end

  def acknowledge
    if @parent.valid?
      @parent.save

      # TODO: reset church if member is true

      redirect root_path, notice: 'somethingish'
    else
      # with buttons to be able to edit the input
      erb :ack, notice: 'somehow an error, probably'
    end
  end

  private

  def set_active_campyear
    @campeyar = helper.get_active_campyear
  end

  def set_parent
    @parent = Parent.new parent_params
  end

  def parent_params
    params.require(:parent).permit(
      :surname, :forename, :telephone, :housephone, :email,
      :street, :house, :post, :city,
      :member, :church,
      :child_count
    )
    # for later
    # child_attributes: %i[id camp_id surname forename birthday medical_condition notes]
  end

  def next_stage(prev_stage)
    @stage = prev_stage
    case prev_stage
    when 'base'
      @stage = 'optional' if @parent.valid? :base
      @stage = 'address' if @parent.member
    when 'optional'
      @stage = 'address' if @parent.valid? :optional
    when 'address'
      @stage = 'contact' if @parent.valid? :address
    when 'contact'
      @stage = 'child_count' if @parent.valid? :contact
    when 'child_count'
      @stage = 'childish' if @parent.valid? :child_count
    end

    @stage
  end
end

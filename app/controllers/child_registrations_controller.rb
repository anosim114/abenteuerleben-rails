class ChildRegistrationsController < ApplicationController
  before_action :set_parent, only: %i[create]
  before_action :set_active_campyear, only: %i[index create]

  p
  def new
    @parent = Parent.new
    @stage = 'base'
  end

  def create
    stage = ''
    if params[:back]
      previous = params[:last_stage]
      previous = 'base' if previous == 'optional' && @parent.member
      stage = previous
    else
      logger.info "the last stage was: #{params[:stage]}"
      # if direction is forward, get next stage
      stage = next_stage params[:stage]
      logger.info "controller:create says it's #{stage}"
    end

    @stage = stage

    if @stage == 'create' && !params[:back] && @parent.valid?
      @parent.save

      @parent.church = '' if @parent.member

      redirect_to root_path, notice: 'Erfolgreich angemeldet. Du wirst in kürze eine Email erhalten.'
    else
      render :new
    end
  end

  private

  def set_active_campyear
    @campyear = helpers.get_active_campyear
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
      logger.info 'go to child_count now'
      @stage = 'child_count' if @parent.valid? :contact
    when 'child_count'
      @stage = 'ack' if @parent.valid? :child_count
    when 'ack'
      @stage = 'create' if @parent.valid? :create
    end

    @stage
  end
end

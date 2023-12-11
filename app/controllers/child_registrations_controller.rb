class ChildRegistrationsController < ApplicationController
  before_action :set_parent, except: %i[index create acknowledge]

  def index
    # show camp info and the registration button
  end

  def new
    @parent = Parent.new
  end

  def create
    return erb :new_name unless @parent.valid? :parent_name

    return erb :new_name unless @parent.valid? :parent_address

    return erb :new_name unless @parent.valid? :parent_contact

    return erb :new_name unless @parent.valid? :parent_member

    return erb :new_name unless @parent.valid? :church

    erb :new_name unless @parent.valid? :child_count

    # start validating children
  end

  def acknowledge
    if @parent.valid?
      @parent.save
      redirect root_path, notice: 'somethingish'
    else
      erb :acknowledge, notice: 'somehow an error, probably'
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
      :surname, :forename, :telephone, :email,
      :street, :house, :post, :city,
      :member, :church,
      child_attributes: %i[id camp_id surname forename birthday medical_condition notes]
    )
  end
end

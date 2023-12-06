class ChildRegistrationsController < ApplicationController
  before_action :admin_only, except: %i[ new create ]
  before_action :set_parent, only: %i[ new_parent_base_info new ]

  def index
    # show camp info and the registration button
  end

  def new_name
    # add the parent name
  end

  def new_address
    # add the parent address
  end

  def new_contact
    # add the parent contact info
  end

  def new_member
    # ask whether the parent in in the local church
  end

  def new_optional_church
    # ask what church the parent is in, if not the local
  end

  def new_child_count
    # ask how many children should be registered
  end

  def new_child_name
    # as child n_th name
  end

  def new_child_camp
    # ask what camp the child should participate in
  end

  def new_child_notes
    # as for child notes (medical, general notes)
  end

  def acknowlege
    # show an overview before the final registering
  end

  def create
    # create with all given information
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
      :member, :church
      child_attributes: [:id, :camp_id, :surname, :forename, :birthday, :medical_condition, :notes])
  end
end


class ChildRegistrationsController < ApplicationController
  before_action :admin_only, except: %i[ new create ]
  before_action :set_parent, only: %i[ new_parent_base_info new ]

  def index
  end

  def new_name
  end

  def new_address
  end

  def new_contact
  end

  def new_member
  end

  def new_optional_church
  end

  def new_child_count
  end

  def new_child_name
  end

  def new_child_camp
  end

  def new_child_notes
  end

  def acknowlege
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
      :member,
      child_attributes: [:id, :camp_id, :surname, :forename, :birthday, :medical_condition, :notes])
  end
end


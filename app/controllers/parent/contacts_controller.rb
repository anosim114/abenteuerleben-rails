module Parent
  class ContactsController < ApplicationController
    def new
      previous_params = session[:parent_contact] unless session[:parent_contact].nil?
      @parent_contact = Contact.new previous_params
    end

    def create
      @parent_contact = Contact.new parent_contact_params

      if @parent_contact.valid?
        session[:parent_contact] = {
          telephone: @parent_contact.telephone,
          housephone: @parent_contact.housephone,
          email: @parent_contact.email
        }

        redirect_to new_parent_location_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def parent_contact_params
      params.require(:parent_contact).permit(
        :telephone,
        :housephone,
        :email
      )
    end
  end
end

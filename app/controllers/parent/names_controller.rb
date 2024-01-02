module Parent
  class NamesController < ApplicationController
    def new
      previous_params = session[:parent_name] unless session[:parent_name].nil?

      @parent_name = Name.new previous_params

      @parent_name.member = true if previous_params.nil?
    end

    def create
      @parent_name = Name.new parent_name_params

      if @parent_name.valid?
        session[:parent_name] = {
          surname: @parent_name.surname,
          forename: @parent_name.forename,
          member: @parent_name.member
        }

        redirect_to new_parent_contact_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def parent_name_params
      params.require(:parent_name).permit(
        :forename,
        :surname,
        :member
      )
    end
  end
end

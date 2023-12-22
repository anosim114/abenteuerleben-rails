module Parent
    class ParentsController < ApplicationController
        before_action :set_active_campyear, only: %i[index]

        def index; end

        def new
            (redirect_to new_parent_name_path; return) if session[:parent_name] == nil
            (redirect_to new_parent_name_path; return) if session[:parent_location] == nil
            (redirect_to new_parent_name_path; return) if session[:parent_contact] == nil

            @parent = Parent.new full_parent_params
        end

        def create
            session.delete(:parent_name)
            session.delete(:parent_location)
            session.delete(:parent_contact)
        end

        private

        def full_parent_params
            {}.merge(
                session[:parent_name],
                session[:parent_location],
                session[:parent_contact],
                children: [Child.new(session[:child])]
            )
        end

        def set_active_campyear
          @campyear = helpers.get_active_campyear
        end
    end
end

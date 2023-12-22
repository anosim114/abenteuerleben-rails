module Parent
    class ParentsController < ApplicationController
        before_action :set_active_campyear, only: %i[index]

        def index
          reset_session
        end

        def new
            (redirect_to new_parent_name_path; return) if session[:parent_name] == nil
            (redirect_to new_parent_name_path; return) if session[:parent_location] == nil
            (redirect_to new_parent_name_path; return) if session[:parent_contact] == nil
            (redirect_to new_parent_child_stat; return) if session[:parent_child_stat] == nil

            @parent = Parent.new parent_params
            @parent.children = child_params
        end

        def create
          @parent = Parent.new parent_params

          if @parent.valid?
            @parent.save

            @parent.children = child_params
            @parent.children.each do |c|
              c.save
            end

            reset_session
            redirect_to root_path, notice: 'Erfolgreich angemeldet, eine email mit mehr Infos ist auf dem weg zu dir'
          else
            logger.debug 'parent is not yet valid'
            logger.debug @parent.errors.to_json
            render :new, status: :unprocessable_entity
          end
        end

        private

        def parent_params
            {}.merge(
                session[:parent_name],
                session[:parent_location],
                session[:parent_contact]
            )
        end

        def child_params
          session[:children].map do |c|
            Child.new(c)
          end
        end

        def set_active_campyear
          @campyear = helpers.get_active_campyear
        end

        def reset_session
          session.delete(:parent_name)
          session.delete(:parent_location)
          session.delete(:parent_contact)
          session.delete(:parent_child_stat)
          session.delete(:children)
        end
    end
end

module Parent
  class ParentsController < ApplicationController
    before_action :set_active_campyear, only: %i[index]

    def index
      reset_session

      @camps = @campyear.camps
    end

    def new
      if session[:parent_name].nil?
        (redirect_to new_parent_name_path
         return)
      end
      if session[:parent_location].nil?
        (redirect_to new_parent_name_path
         return)
      end
      if session[:parent_contact].nil?
        (redirect_to new_parent_name_path
         return)
      end
      if session[:parent_child_stat].nil?
        (redirect_to new_parent_child_stat
         return)
      end

      @parent = Parent.new parent_params
      @parent.children = child_params
    end

    def create
      @parent = Parent.new parent_params

      if @parent.valid?
        @parent.save

        @parent.children = child_params
        @parent.children.each(&:save)

        reset_session
        ChildRegistrationMailer.with(parent: @parent).registered_mail.deliver_later
        redirect_to root_path, notice: 'Erfolgreich angemeldet, eine email mit mehr Infos ist auf dem weg zu dir'
      else
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

module Parent
  class ParentsController < ApplicationController
    before_action :set_active_campyear, only: %i[index]
    before_action :set_parent, only: %i[edit update]

    add_breadcrumb helpers.t('admin.dashboard.title'), :admin_dashboard_path
    add_breadcrumb 'Eltern'

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

    def create # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      @parent = Parent.new parent_params
      @parent.children = child_params

      if @parent.valid? && @parent.children.each.filter(&:invalid?).empty?
        @parent.save

        @parent.children.each do |child|
          child.save
          ChildRegistrationMailer.with(parent: @parent, child: child).registered_mail.deliver_later
        end

        reset_session
        redirect_to root_path, notice: "Erfolgreich angemeldet, eine Email mit mehr Infos ist auf dem Weg zu dir"
      else
        logger.error "#{@parent.to_json} was not valid because:"
        logger.error @parent.errors.messages if @parent.errors.messages
        @parent.children.each do |c|
          logger.error c.errors.messages if c.errors.messages
        end
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      add_breadcrumb "#{@parent.surname}, #{@parent.forename}"
    end

    def update
      add_breadcrumb "#{@parent.surname}, #{@parent.forename}"
      logger.info 'info, parent was not saved'

      if @parent.update(parent_params_edit)
        redirect_to @parent.children.first
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def resend_registration_email
      unless Parent.exists? params[:id]
        logger.error "Trying to resend email for not found parent id: #{params[:id]}"
        render plain: "Die Anmeldung konnte nicht gefunden werden", status: :bad_request
        return
      end

      @parent = Parent.find params[:id]
      # todo: move this into the model
      @parent.children.each do |child|
        ChildRegistrationMailer.with(parent: @parent, child: child).registered_mail.deliver_later
      end

      render plain: "Email erfolgreich verschickt", status: :ok
    end

    private
    def set_parent
      @parent = Parent.find(params[:id])
    end

    def parent_params
      {}.merge(
        session[:parent_name],
        session[:parent_location],
        session[:parent_contact]
      )
    end

    def parent_params_edit
      params.require(:parent_parent).permit(
        :surname, :forename, :telephone, :housephone, :email, :street, :house, :post, :city, :member
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

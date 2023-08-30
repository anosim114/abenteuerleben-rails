class ApplicationController < ActionController::Base
  before_action :set_user
  
  def admin_only
    access_denied unless @current_user.level & 0x111
  end
  
  def moderator_only
    access_denied unless @current_user.level & 0x011
  end  

  def set_user
    # find user in session
    p "== START AUTH =="
    if @current_user.nil? && session[:user_id]
      p "user is nil and we have a sesion id"
      @current_user = User.find_by_id session[:user_id]
    end

    # auth user by username and password
    if @current_user.nil? && params[:user].is_a?(ActionController::Parameters)
      p "user is nil and we have a submitted form"
      @current_user = User.find_by( name: params[:user][:name], password_hash: params[:user][:password] )
    end

    if @current_user
      p 'user exists and will be used'
      session[:user_id] = @current_user.id
    else
      @current_user = User.new
      @current_user.level = 0x000
    end
  end
end


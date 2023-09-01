class ApplicationController < ActionController::Base
  before_action :set_user
  
  def admin_only
    redirect_to root_path unless @current_user.level >= 0x111
  end
  
  def moderator_only
    redirect_to root_path unless @current_user.level >= 0x011
  end  
  
  def logged_in
    redirect_to root_path unless @current_user.level >= 0x001
  end  

  def set_user
    # find user in session
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by_id session[:user_id]
    end

    # auth user by username and password
    if @current_user.nil? && params[:user].is_a?(ActionController::Parameters)
      @current_user = User.find_by( name: params[:user][:name], password_hash: params[:user][:password] )
    end

    if @current_user
      session[:user_id] = @current_user.id
    else
      @current_user = User.new
      @current_user.level = 0x000
    end
  end
end


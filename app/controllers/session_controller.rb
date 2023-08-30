class SessionController < ApplicationController
  def login
    @user = User.new
  end

  def auth
    if @current_user.id
      redirect_to root_path
    else
      @error = true
      render :login, status: 401
    end
  end

  def logout
    reset_session
    redirect_to login_path
  end
end

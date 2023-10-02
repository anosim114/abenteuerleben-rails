class AdminController < ApplicationController
  before_action :admin_only

  def dashboard
  end

  def dev
  end
end

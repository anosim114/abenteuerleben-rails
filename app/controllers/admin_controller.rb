# The controller for the admins
# it hosts the page which exposes all the admin-only pages
class AdminController < ApplicationController
  before_action :admin_only

  def dashboard
    @unread_messages = Message.where(read: nil).or(Message.where(read: false)).count
    @helper_count = Helper.all.count
  end

  def dev; end
end

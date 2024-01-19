# The controller for the admins
# it hosts the page which exposes all the admin-only pages
class AdminController < ApplicationController
  before_action :admin_only

  def dashboard
    @unread_messages = Message.where(read: nil).or(Message.where(read: false)).count
    # TODO: calculate per campyear
    @helper_count = Helper.all.count

    # TODO: calculate per campyear
    @child_count = Child.all.count
  end

  def dev; end

  def file_upload
    @f = File.new
  end

  def file_create
    file_params = params.require(:file).permit(:file, :author, :note)

    @f = File.new file_params
    @f.file_name = AbenteuerLeben::StorageUtils.persist @f.file, prefix: 'admin/file'
    @file64 = Base64.encode64 @f.file.read

    render :file_upload
  end

  class File
    include ActiveModel::Model

    attr_accessor :file, :file_name, :note, :author
  end
end

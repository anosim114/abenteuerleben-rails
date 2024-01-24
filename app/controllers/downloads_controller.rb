class DownloadsController < ApplicationController
  before_action :set_download, only: %i[ show edit update destroy download ]
  before_action :admin_only, except: %i[ index download ]

  def index
    @download_page_before = Page.where(url: 'download_before').first!
    @download_page_after = Page.where(url: 'download_after').first!
    @downloads = Download.where(download_area: true)
  end

  def admin
    @downloads = Download.all
  end

  def show; end

  def new
    @download = Download.new
  end

  def edit; end

  def create
    @download = Download.new(download_params)

    if @download.save
      redirect_to download_url(@download), notice: "Download was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @download.update(download_params)
      redirect_to download_url(@download), notice: "Download was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @download.destroy

    redirect_to downloads_admin_url, notice: "Download was successfully destroyed."
  end

  private

  def set_download
    @download = Download.find(params[:id])
  end

  def download_params
    params.require(:download).permit(:name, :description, :download_area, :file)
  end
end

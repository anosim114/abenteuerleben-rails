class DownloadsController < ApplicationController
  before_action :set_download, only: %i[ show edit update destroy download ]
  before_action :admin_only, except: %i[ index download ]

  # GET /downloads or /downloads.json
  def index
    @download_page_before = Page.where(url: 'download_before').first!
    @download_page_after = Page.where(url: 'download_after').first!
    @downloads = Download.where(download_area: true)
  end

  def admin
    @downloads = Download.all
  end

  # GET /downloads/1 or /downloads/1.json
  def show
  end

  # GET /downloads/new
  def new
    @download = Download.new
  end

  # GET /downloads/1/edit
  def edit
  end

  # POST /downloads or /downloads.json
  def create
    @download = Download.new(download_params)

    if @download.save
      redirect_to download_url(@download), notice: "Download was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /downloads/1 or /downloads/1.json
  def update
    if @download.update(download_params)
      redirect_to download_url(@download), notice: "Download was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /downloads/1 or /downloads/1.json
  def destroy
    @download.destroy

    redirect_to downloads_admin_url, notice: "Download was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def download_params
      params.require(:download).permit(:name, :description, :download_area, :file)
    end
end

class PagesController < ApplicationController
  before_action :set_page, only: %i[ edit update destroy ]
  before_action :admin_only, except: %i[ show ]

  # GET /pages or /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1 or /pages/1.json
  def show
    @page = Page.find_by url: params[:id]
    p params[:id]
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)
    p 'create new page'

    if @page.save
      redirect_to page_url(@page.url), notice: "Seite erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    if @page.update(page_params)
      redirect_to page_url(@page.url), notice: "Seite erfolgreich geändert."
    else
       render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy

    redirect_to pages_url, notice: "Seite erfolgreich gelöscht."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:url, :content)
    end
end

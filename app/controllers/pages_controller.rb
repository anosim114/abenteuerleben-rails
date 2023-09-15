class PagesController < ApplicationController
  # before_action :set_page, only: %i[ edit update destroy ]
  # before_action :admin_only, except: %i[ show ]

  # # GET /pages or /pages.json
  # def index
  #   @pages = Page.all
  # end

  # # GET /pages/1 or /pages/1.json
  # def show
  #   @page = Page.find_by url: params[:id]
  #   p params[:id]
  # end

  # # GET /pages/new
  # def new
  #   @page = Page.new
  # end

  # # GET /pages/1/edit
  # def edit
  # end

  # # POST /pages or /pages.json
  # def create
  #   @page = Page.new(page_params)
  #   p 'create new page'

  #   respond_to do |format|
  #     if @page.save
  #       p 'page saved'
  #       p @page.to_json
  #       format.html { redirect_to page_url(@page.url), notice: "Page was successfully created." }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /pages/1 or /pages/1.json
  # def update
  #   respond_to do |format|
  #     if @page.update(page_params)
  #       format.html { redirect_to page_url(@page.url), notice: "Page was successfully updated." }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /pages/1 or /pages/1.json
  # def destroy
  #   @page.destroy

  #   respond_to do |format|
  #     format.html { redirect_to pages_url, notice: "Page was successfully destroyed." }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_page
  #     @page = Page.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def page_params
  #     params.require(:page).permit(:url, :content)
  #   end
end

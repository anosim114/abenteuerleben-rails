class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :admin_only, except: %i[ new create ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all.order(id: :desc)
  end

  # GET /messages/1 or /messages/1.json
  def show
    @message.read = true
    @message.save
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to(root_path, notice: "Nachricht erfolgreich abgeschickt.")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    if @message.update(message_params)
      redirect_to message_url(@message), notice: "Nachricht erfolgreich geändert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    redirect_to messages_path, notice: "Nachricht erfolgreich gelöscht."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:name, :email, :message, :read)
    end
end

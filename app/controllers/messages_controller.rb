class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new

    @messages = @room.messages.includes(:user)
    # binding.pry
  end
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    #この時点で紐づいているroomsテーブルと
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end

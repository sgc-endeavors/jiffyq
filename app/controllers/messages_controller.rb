class MessagesController < ApplicationController
  def index
  end

  def new
    @new_message = Message.new
    if params[:origin_id] && params[:type] == "existing"
      @type = params[:type]
      existing_message = Message.find(params[:origin_id].to_i)
      @new_message.title = existing_message.title
      @new_message.image = existing_message.image
      @new_message.question = existing_message.question
      @new_message.button1 = existing_message.button1
      @new_message.button2 = existing_message.button2
      @new_message.response1 = existing_message.response1
      @new_message.response2 = existing_message.response2
      @new_message.address = existing_message.address

    end
  end

  def create
    new_message = Message.new(params[:message])
    new_message.save!
    redirect_to message_path(new_message)
  end

  def show
    @response = params[:response].to_i
    @message = Message.find(params[:id])
  end

  def edit
    @draft_message = Message.find(params[:id])
  end

  def update
    updated_draft_message = Message.find(params[:id])
    if params[:send_status] == "send"
      # send message
      updated_draft_message.status = "sent"
    else
      updated_draft_message.update_attributes(params[:message])
    end
    updated_draft_message.save!
    redirect_to message_path(updated_draft_message)
  end

  def destroy
  end
end

class MessagesController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :landing_page, :show, :about ]

  def about

  end
 

  def landing_page

    render :landing_page
  end

  def send_options
    @message = Message.find(params[:message_id])
    @message.status = "sent"
    @message.save! 
    render :send_options
  end

  def index
    @messages = Message.where(user_id: current_user.id).order("id desc")
  end

  def new
    
    if params[:image_id] != nil || params[:origin_id] != nil
     
      @new_message = Message.new
      @new_message.image_id = params[:image_id]
      @new_message.button1 = "Yes"
      @new_message.button2 = "No"
      @new_message.user_id = current_user.id
      #@new_message.origin_message = Message.last.origin_message.to_i + 1  
      #@new_image = params[:key]
      if params[:origin_id] 
        params[:forward] ? @type = "forward" : @type = "reply"
        existing_message = Message.find(params[:origin_id].to_i)
        @new_message.question = existing_message.question
        @new_message.origin_message = existing_message.origin_message
        @new_message.button1 = existing_message.button1
        @new_message.button2 = existing_message.button2
        @new_message.response1 = existing_message.response1
        @new_message.response2 = existing_message.response2
        @new_message.image_id = existing_message.image_id     
      end
      
    else
      redirect_to new_image_path and return  
    end
      render :new, anchor: "qod"    
  end

  def create
    new_message = Message.new(params[:message])
    new_message.identifier = SecureRandom.hex(4)
    new_message.page_views = 0
    new_message.save!

    if new_message.origin_message == nil
      new_message.origin_message = new_message.id
    end
    new_message.save!
    
    redirect_to message_path(new_message, anchor: "view-line")
  end

  def show
    @response = params[:response].to_i
    @message = Message.where(identifier: params[:id]).first
    if @message.user != current_user && @response == 0
      @message.page_views = @message.page_views.to_i + 1
      @message.save!
    end
  end

  def edit
    @draft_message = Message.where(identifier: params[:id]).first
    if @draft_message.status == "sent"
      redirect_to message_path(@draft_message, anchor: "qod") and return
    end
  end

  def update
    user = User.find(current_user.id)
    updated_draft_message = user.messages.find_by_identifier(params[:id])
    #updated_draft_message = Message.where(identifier: params[:id]).first
    if params[:send_status] == "send"
      # send message
      updated_draft_message.status = "sent"
    else
      updated_draft_message.update_attributes(params[:message])
    end
    updated_draft_message.save!
    redirect_to message_path(updated_draft_message, anchor: "qod")
  end

  def destroy #(post/delete)
    #Message.where(identifier: params[:id]).first.destroy
    # user = User.find(current_user.id)
    # user.messages.find_by_identifier(params[:id]).destroy
    # redirect_to messages_path and return
  user = User.find(current_user.id)
  deleted_message = user.messages.find_by_identifier(params[:identifier])  
#  deleted_message = Message.where(identifier: params[:identifier]).first

  if deleted_message.id == deleted_message.origin_message
    if Image.where(id: params[:id]).first != nil
      Image.find(params[:id]).destroy
    end 
  end
  deleted_message.destroy
  redirect_to messages_path and return



  end
end

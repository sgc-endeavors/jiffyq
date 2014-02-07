class PollsController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :landing_page, :show, :about, :legal ]

  def about

  end
 

 def legal

 end

  def landing_page

    render :landing_page
  end

  def send_options
    @poll = Poll.find(params[:poll_id])
    @poll.status = "sent"
    @poll.save! 
    render :send_options
  end

  def index
    @polls = Poll.where(user_id: current_user.id).order("id desc")
  end

  def new
    
    if params[:image_id] != nil || params[:origin_id] != nil
     
      @new_poll = Poll.new
      @new_poll.image_id = params[:image_id]
      @new_poll.button1 = "Yes"
      @new_poll.button2 = "No"
      @new_poll.user_id = current_user.id
      #@new_poll.origin_poll = Poll.last.origin_poll.to_i + 1  
      #@new_image = params[:key]
      if params[:origin_id] 
        params[:forward] ? @type = "forward" : @type = "reply"
        existing_poll = Poll.find(params[:origin_id].to_i)
        @new_poll.question = existing_poll.question
        @new_poll.origin_poll = existing_poll.origin_poll
        @new_poll.button1 = existing_poll.button1
        @new_poll.button2 = existing_poll.button2
        @new_poll.response1 = existing_poll.response1
        @new_poll.response2 = existing_poll.response2
        @new_poll.image_id = existing_poll.image_id     
      end
      
    else
      redirect_to new_image_path and return  
    end
      render :new, anchor: "qod"    
  end

  def create
    new_poll = Poll.new(params[:poll])
    new_poll.identifier = SecureRandom.hex(4)
    new_poll.page_views = 0
    new_poll.save!

    if new_poll.origin_poll == nil
      new_poll.origin_poll = new_poll.id
    end
    new_poll.save!
    
    redirect_to poll_path(new_poll, anchor: "view-line")
  end

  def show
    @response = params[:response].to_i
    @poll = Poll.where(identifier: params[:id]).first
    @poll.count_page_views(@response, current_user)
  end

  def edit
    @draft_poll = Poll.where(identifier: params[:id]).first
    if @draft_poll.status == "sent"
      redirect_to poll_path(@draft_poll, anchor: "qod") and return
    end
  end

  def update
    user = User.find(current_user.id)
    updated_draft_poll = user.polls.find_by_identifier(params[:id])
    if params[:send_status] == "send"
      updated_draft_poll.status = "sent"
    else
      updated_draft_poll.update_attributes(params[:poll])
    end
    updated_draft_poll.save!
    redirect_to poll_path(updated_draft_poll, anchor: "qod")
  end

  def destroy #(post/delete)
    user = User.find(current_user.id)
    deleted_poll = user.polls.find_by_identifier(params[:identifier])  
    deleted_poll.destroy_related_image(params[:id])
    deleted_poll.destroy
    redirect_to polls_path and return
  end
end

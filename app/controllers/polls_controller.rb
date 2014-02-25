class PollsController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :home, :show, :about, :legal, :send_options ]

  def about

  end
 

 def legal

 end

  def home

    render :home
  end

  def send_options
    @poll = Poll.where(identifier: params[:identifier]).first
    @poll.status = "sent"
    @poll.save! 
    render :send_options
  end

  def index
    @polls = Poll.where(user_id: current_user.id).order("id desc")
    @favorites = Favorite.where(user_id: current_user.id).order("id desc")
    users = User.all.sort_by { |user| user.total_views * -1 }

    while @rank == nil
      rank = 0
      users.each do |user|
        rank += 1
        if current_user == user
          @rank = rank
          break
        end
      end
    end
  end

  def new
    if params[:image_id] != nil #|| params[:origin_id] != nil
      @new_poll = Poll.new
      @new_poll.image_id = params[:image_id]
      @new_poll.button1 = "Yes"
      @new_poll.button2 = "No"
      @new_poll.user_id = current_user.id      
    else
      redirect_to new_image_path and return  
    end
      render :new, anchor: "1"    
  end

  def create
    new_poll = Poll.new(params[:poll])
    new_poll.identifier = SecureRandom.hex(4)
    new_poll.page_views = 0
    if new_poll.save
      redirect_to poll_path(new_poll, anchor: "1") and return
    else
      flash[:error] = "Your response(s) is/are too long.  Keep response length to less than 500 characters"
      @new_poll = Poll.new(params[:poll])
      render :new and return
    end
  end

  def show
    @response = params[:response].to_i
    @poll = Poll.where(identifier: params[:id]).where("inactive is null").first
    @poll.count_page_views(@response, current_user)
  end

  def edit
    @draft_poll = Poll.where(identifier: params[:id]).first
    if @draft_poll.status == "sent"
      redirect_to poll_path(@draft_poll, anchor: "1") and return
    end
  end

  def update
    user = User.find(current_user.id)
    updated_draft_poll = user.polls.find_by_identifier(params[:id])
    updated_draft_poll.update_attributes(params[:poll])
    if updated_draft_poll.save
         redirect_to poll_path(updated_draft_poll, anchor: "1") and return
    else
      flash[:error] = "Your response(s) is(are) too long.  Keep response length to less than 500 characters"
      @draft_poll = Poll.new(params[:poll])
      render :edit and return
    end
  end

  def destroy #(post/delete)
    user = User.find(current_user.id)
    deleted_poll = user.polls.find_by_identifier(params[:identifier])  
    deleted_poll.destroy_related_image(params[:id])
    deleted_poll.destroy_related_favorite(deleted_poll.id)
    deleted_poll.destroy
    redirect_to polls_path and return
  end
end

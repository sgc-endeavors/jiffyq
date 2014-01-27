class ImagesController < ApplicationController
  
  before_filter :authenticate_user!


  def index
  @images = Image.all
  authorize! :manage, Image  
  render :index
  end

  def new 
    @uploader = Image.new#.s3_image_loc
  end

  def create
    new_image = Image.new(params[:image])

    if new_image.save
      redirect_to new_message_path(image_id: new_image.id, anchor: "qod")
    else
      render :index
    end
  end

  def destroy
   
  deleted_message = Message.where(identifier: params[:identifier]).first

  if deleted_message.id == deleted_message.origin_message
    if Image.where(id: params[:id]).first != nil
      Image.find(params[:id]).destroy
    end 
  end
  deleted_message.destroy
  redirect_to messages_path and return
  end
end

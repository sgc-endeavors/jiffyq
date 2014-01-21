class ImagesController < ApplicationController
  
  before_filter :authenticate_user!


  def index
  end

  def new
   
  @uploader = Image.new#.s3_image_loc
  @origin_message_id = params[:origin_id]
  end

  def create
    new_image = Image.new(params[:image])

    if new_image.save
      redirect_to new_message_path(image_id: new_image.id, origin_message_id: params[:origin_message_id])
    else
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

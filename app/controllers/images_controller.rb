class ImagesController < ApplicationController
  
  before_filter :authenticate_user!

  def new 
    @uploader = Image.new#.s3_image_loc
  end

  def create
    new_image = Image.new(params[:image])
    new_image.user_id = current_user.id

    if new_image.save
      redirect_to new_poll_path(image_id: new_image.id, anchor: "1")
    else
      render :index
    end
  end

end

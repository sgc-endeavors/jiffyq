class ImagesController < ApplicationController
  def index
    @uploader = Image.new.s3_image_loc
    @uploader.success_action_redirect = new_image_url
  end

  def new
    @image = Image.new(key: params[:key])
  end

  def create
    new_image = Image.new(params[:image])
    if new_image.save
      redirect_to new_message_path(image_id: new_image.id)
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

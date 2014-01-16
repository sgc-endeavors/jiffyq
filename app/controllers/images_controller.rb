class ImagesController < ApplicationController
  def index
  end

  def new
   
  @uploader = Image.new#.s3_image_loc
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
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to new_message_path
  end
end

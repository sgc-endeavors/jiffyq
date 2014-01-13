class ImagesController < ApplicationController
  def index
  
  end

  def new
    @uploader = Image.new.s3_image_key
    @uploader.success_action_redirect = new_message_url
  end

  def create
    #binding.pry
    new_image = Image.new(params[:key])
    new_image.save!
    redirect_to new_message_path

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

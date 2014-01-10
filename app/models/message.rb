class Message < ActiveRecord::Base
  attr_accessible :address, :button1, :button2, :title, :image, :origin_message, :question, :response1, :response2, :status
  mount_uploader :image, ImageUploader
end

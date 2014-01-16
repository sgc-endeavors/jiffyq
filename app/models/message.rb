class Message < ActiveRecord::Base
  attr_accessible :address, :button1, :button2, :image_id, :origin_message, :question, :response1, :response2, :status
  belongs_to :image
end

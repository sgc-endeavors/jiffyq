class Message < ActiveRecord::Base
  attr_accessible :button1, :button2, :image_id, :origin_message, :question, :response1, :response2, :user_id, :status, :identifier, :page_views
  belongs_to :image
  belongs_to :user

  def to_param
  	"#{identifier}".parameterize
  end
end

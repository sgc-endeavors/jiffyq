class Message < ActiveRecord::Base
  attr_accessible :button1, :button2, :image_id, :origin_message, :question, :response1, :response2, :user_id, :status, :identifier, :page_views
  belongs_to :image
  belongs_to :user

  def to_param
  	"#{identifier}".parameterize
  end

  def destroy_related_image(image_id)
  	image = Image.where(id: image_id).first
  	if image != nil
    	image.destroy
    end 
  end

  def count_page_views
  	#if self.user != current_user #&& @response == 0

  		self.page_views = self.page_views.to_i + 1
    	self.save!
  	#end
  end

end

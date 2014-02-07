class Image < ActiveRecord::Base
  attr_accessible :s3_image_loc, :image_processed
  mount_uploader :s3_image_loc, ImageUploader
  has_many :polls
  belongs_to :user

 #after_save :enqueue_image

  # def image_name
  # 	File.basename(s3_image_loc.path || s3_image_loc.filename) if s3_image_loc
  # end

  # def enqueue_image
    
  # 	ImageWorker.perform_async(id, key) if key.present? #&& Image.find(id).image_processed != true
  #     end

  # class ImageWorker
  # 	include Sidekiq::Worker

  # 	def perform(id, key)
  # 		image = Image.find(id)
  # 		image.key = key
  # 		image.remote_s3_image_loc_url = image.s3_image_loc.direct_fog_url(with_path: true)      
  #     image.bs_field = "bs"
  #     image.image_processed = true
     
  #     image.save!
  #   end
  # end

end

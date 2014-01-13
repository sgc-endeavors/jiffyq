class Image < ActiveRecord::Base
  attr_accessible :s3_image_key
  mount_uploader :s3_image_key, ImageUploader
  has_many :messages
end

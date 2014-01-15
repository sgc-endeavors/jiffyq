class NameChangeForS3ImageKey < ActiveRecord::Migration
  def up
  	rename_column :images, :s3_image_key, :s3_image_loc
  end

  def down
  	rename_column :images, :s3_image_loc, :s3_image_key
  end
end

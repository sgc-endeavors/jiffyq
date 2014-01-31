class RemoveImageProcessedAndBsField < ActiveRecord::Migration
  def up
  	remove_column :images, :bs_field
  	remove_column :images, :image_processed
  end

  def down
  	add_column :images, :image_processed, :boolean
  	add_column :images, :bs_field, :string
  end
end

class AddImageProcessedToImage < ActiveRecord::Migration
  def up
    add_column :images, :image_processed, :boolean
  end

    def down
    remove_column :images, :image_processed
  end
end

class AddImageIdToPoll < ActiveRecord::Migration
  def up
  	add_column :polls, :image_id, :integer
  	remove_column :polls, :image
  end

  def down
  	remove_column :polls, :image_id
  	add_column :polls, :image, :string

  end
end

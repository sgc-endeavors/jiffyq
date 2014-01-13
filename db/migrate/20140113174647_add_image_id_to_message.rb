class AddImageIdToMessage < ActiveRecord::Migration
  def up
  	add_column :messages, :image_id, :integer
  	remove_column :messages, :image
  end

  def down
  	remove_column :messages, :image_id
  	add_column :messages, :image, :string

  end
end

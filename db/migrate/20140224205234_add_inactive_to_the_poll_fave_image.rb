class AddInactiveToThePollFaveImage < ActiveRecord::Migration
  def up
  	add_column :polls, :inactive, :boolean
  	add_column :images, :inactive, :boolean
  	add_column :favorites, :inactive, :boolean
  end
  def down
  	remove_column :polls, :inactive
  	remove_column :images, :inactive
  	remove_column :favorites, :inactive

  end
end

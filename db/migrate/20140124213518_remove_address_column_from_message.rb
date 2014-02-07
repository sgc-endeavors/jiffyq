class RemoveAddressColumnFromPoll < ActiveRecord::Migration
  def up
  	remove_column :polls, :address
  end

  def down
  	add_column :polls, :address, :string
  end
end

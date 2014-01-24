class RemoveAddressColumnFromMessage < ActiveRecord::Migration
  def up
  	remove_column :messages, :address
  end

  def down
  	add_column :messages, :address, :string
  end
end

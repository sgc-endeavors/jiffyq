class DropStatusFromComplaint < ActiveRecord::Migration
  def up
  	remove_column :complaints, :status
  	remove_column :complaints, :type
  end

  def down
    add_column :complaints, :status, :string
  	add_column :complaints, :type, :string
  end
end

class CreateStatus < ActiveRecord::Migration
  def up
  	add_column :polls, :status, :string
  end

  def down
  	remove_column :polls, :status
  end
end

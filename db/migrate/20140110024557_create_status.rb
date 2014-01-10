class CreateStatus < ActiveRecord::Migration
  def up
  	add_column :messages, :status, :string
  end

  def down
  	remove_column :messages, :status
  end
end

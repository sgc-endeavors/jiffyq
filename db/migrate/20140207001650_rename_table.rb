class RenameTable < ActiveRecord::Migration
  def up
  	rename_table :messages, :polls
  end

  def down
  	rename_table :polls, :messages
  end
end

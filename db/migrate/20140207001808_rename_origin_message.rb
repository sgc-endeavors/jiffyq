class RenameOriginMessage < ActiveRecord::Migration
  def up
  	rename_column :polls, :origin_message, :origin_poll
  end

  def down
  	rename_column :polls, :origin_poll, :origin_message
  end
end

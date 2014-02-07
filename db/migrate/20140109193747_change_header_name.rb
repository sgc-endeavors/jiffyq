class ChangeHeaderName < ActiveRecord::Migration
  def up
  	rename_column :polls, :header, :title
  end

  def down
  	rename_column :polls, :title, :header
  end
end

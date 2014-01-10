class ChangeHeaderName < ActiveRecord::Migration
  def up
  	rename_column :messages, :header, :title
  end

  def down
  	rename_column :messages, :title, :header
  end
end

class RemoveTheTitleColumn < ActiveRecord::Migration
  def up
  	remove_column :polls, :title
  end

  def down
  	add_column :polls, :title, :string
  end
end

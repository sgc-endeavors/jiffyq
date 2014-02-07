class AddPageViewsToPolls < ActiveRecord::Migration
  def change
  	add_column :polls, :page_views, :integer
  end
end

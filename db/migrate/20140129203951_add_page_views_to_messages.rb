class AddPageViewsToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :page_views, :integer
  end
end

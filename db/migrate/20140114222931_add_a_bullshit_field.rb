class AddABullshitField < ActiveRecord::Migration
  def up
  	add_column :images, :bs_field, :string
  end

  def down
  	remove_column :images, :bs_field
  end
end

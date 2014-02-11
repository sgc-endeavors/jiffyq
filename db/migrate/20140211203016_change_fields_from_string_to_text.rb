class ChangeFieldsFromStringToText < ActiveRecord::Migration
  def up
  	change_column :polls, :response1, :text
  	change_column :polls, :response2, :text
  end

  def down
    change_column :polls, :response1, :string
  	change_column :polls, :response2, :string

  end
end

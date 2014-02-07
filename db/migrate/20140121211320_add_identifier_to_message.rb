class AddIdentifierToPoll < ActiveRecord::Migration
  def change
  	add_column :polls, :identifier, :string
  end
end

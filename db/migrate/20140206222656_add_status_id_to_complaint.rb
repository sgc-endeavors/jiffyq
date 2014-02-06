class AddStatusIdToComplaint < ActiveRecord::Migration
  def change
  	add_column :complaints, :complaint_status_id, :integer
  end
end

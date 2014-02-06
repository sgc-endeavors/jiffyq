class AddProblemIdToComplaint < ActiveRecord::Migration
  def change
  	add_column :complaints, :problem_id, :integer
  end
end

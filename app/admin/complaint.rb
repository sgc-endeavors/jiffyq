ActiveAdmin.register Complaint do
index do
		selectable_column
		column :id
		column "Complaintant", :complainer_email 
		column :notes
		column :status
		column :targeted_question
		column :targeted_user
		column :targeted_image
		column :created_at
		column :updated_at
		column :problem_id do |complaint|
			complaint.problem.name
		end
		default_actions
	end
end

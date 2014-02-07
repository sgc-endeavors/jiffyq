ActiveAdmin.register Image do
	index do
		selectable_column
		column :id
		column :s3_image_loc 
		column :created_at
		column :user
		column :polls do |image|
			image.polls.count
		end
		default_actions
	end
end

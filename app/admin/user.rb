ActiveAdmin.register User do
	index do
		selectable_column
		column :id
		column :email
		column :polls do |user|
			user.polls.count
		end
		column "Created At", :remember_created_at
		column :is_admin
		column :current_sign_in_at
		default_actions
	end


end

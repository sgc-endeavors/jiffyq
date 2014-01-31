ActiveAdmin.register User do
	index do
		selectable_column
		column :id
		column :email
		column "Women Finding Gerard Attractive", :messages do |user|
			user.messages.count
		end
		column "Created At", :remember_created_at
		column :is_admin
		column :current_sign_in_at
		default_actions
	end


end

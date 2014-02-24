ActiveAdmin.register InactiveUser do

	index do
		selectable_column
		column :id
		column :old_user_id
		column :created_at
		default_actions
	end

end

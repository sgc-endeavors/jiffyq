ActiveAdmin.register Poll do

	index do
		selectable_column
		column :id
		column :question
		column :button1
		column :button2
		column :response1
		column :response2
		column :identifier
		column :status
		column :page_views
		column :image_id
		column :user_id
		column :origin_poll
		column :updated_at
		column :inactive
		default_actions
	end

	controller do
		def show
			@poll = Poll.where(identifier: params[:id]).first
		end
		def edit
			@poll = Poll.where(identifier: params[:id]).first
		end
		def update
			@poll = Poll.where(identifier: params[:id]).first
			@poll.update_attributes(params[:poll])
			@poll.save!
			redirect_to admin_polls_path
		end
		def destroy
			@poll = Poll.where(identifier: params[:id]).first
			if Image.where(id: @poll.image_id).first != nil
				@poll.image.destroy
			end
			@poll.destroy
			redirect_to admin_polls_path
		end
	end
end

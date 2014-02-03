ActiveAdmin.register Message do

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
		column :origin_message
		column :updated_at
		default_actions
	end

	controller do

	# 	def new
	# 		redirect_to admin_messages_path
	# 	end
		def show
			@message = Message.where(identifier: params[:id]).first
		end
		def edit
			@message = Message.where(identifier: params[:id]).first
		end
		def update
			@message = Message.where(identifier: params[:id]).first
			@message.update_attributes(params[:message])
			@message.save!
			redirect_to admin_messages_path
		end
		def destroy
			@message = Message.where(identifier: params[:id]).first
			@message.destroy
			if @message.user_id == @message.image.user_id
				@message.image.destroy
			end
			redirect_to admin_messages_path
		end
	end

end

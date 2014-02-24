class Users::RegistrationsController < Devise::RegistrationsController

	 def destroy
    
	 	inactive_id = current_user.id
	 	inactive_user = InactiveUser.new
	 	inactive_user.old_user_id = inactive_id
	 	inactive_user.save!
	 	
	 	inactivated_polls = Poll.where(user_id: inactive_id)
	 	inactivated_polls.each do |inactivated_poll|
	 		inactivated_poll.inactive = true
	 		inactivated_poll.save!
	 		inactivated_poll.favorites.each do |favorite|
	 			favorite.delete
	 		end
	 	end

		inactivated_images = Image.where(user_id: inactive_id)
	 	inactivated_images.each do |inactivated_image|
	 		inactivated_image.inactive = true
	 		inactivated_image.save!
	 	end




    
    super
    # resource.destroy
    # Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    # set_flash_message :notice, :destroyed if is_flashing_format?
    # yield resource if block_given?
    # respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

end
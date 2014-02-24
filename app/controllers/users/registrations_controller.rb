class Users::RegistrationsController < Devise::RegistrationsController

	 def destroy
    
	 	inactive_id = current_user.id
	 	
	 	#Creates a new inactive user
	 	inactive_user = InactiveUser.new
	 	inactive_user.old_user_id = inactive_id
	 	inactive_user.save!
	 	
	 	#Inactivates each of the inactive user's polls
	 	inactivated_polls = Poll.where(user_id: inactive_id)
	 	inactivated_polls.each do |inactivated_poll|
	 		inactivated_poll.inactive = true
	 		inactivated_poll.save!
	 		#Eliminates any favorites associated w/ the particular poll
	 		inactivated_poll.favorites.each do |favorite|
	 			favorite.delete
	 		end
	 	end

		#Inactivates each of the inactive user's images.
		inactivated_images = Image.where(user_id: inactive_id)
	 	inactivated_images.each do |inactivated_image|
	 		inactivated_image.inactive = true
	 		inactivated_image.save!
	 	end
    
    super

  end

end
require 'spec_helper'

describe "Devise#cancel_my_account" do 
	
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:image) { FactoryGirl.create(:image, user_id: user.id) }
	
	

	context "visitor has logged in as a user" do
		before(:each) { sign_in_as_existing_user(user) }
		
		context " user has created 2 poll questions " do
			before(:each) do 
				@poll1 = FactoryGirl.create(:poll, user_id: user.id, image_id: image.id)
				@poll2 = FactoryGirl.create(:poll, user_id: user.id, image_id: image.id)
			end

			
			context "user has 'favorited' someone else's poll question" do
				before(:each) do
					@user_favorite = FactoryGirl.create(:favorite, user_id: user.id)
				end

				context "someone has favorited the user's questions" do
					before(:each) do
						@favorite1 = FactoryGirl.create(:favorite, poll_id: @poll1.id)
						@favorite2 = FactoryGirl.create(:favorite, poll_id: @poll2.id)
					end					

					context 'visitor wants to cancel' do
						before(:each) do
							click_on "Edit Profile"
							click_on "Cancel my account"
						end
						
						it "creates an 'inactive user' using the user's user_id as an identifier" do
							InactiveUser.last.old_user_id.should == user.id
						end

						it "deletes the user from the User model" do
							expect {User.find(user.id)}.to raise_error(ActiveRecord::RecordNotFound)
						end

						it "inactivates each of the user's poll questions" do
							Poll.find(@poll1.id).inactive.should == true
							Poll.find(@poll2.id).inactive.should == true
						end

						it "deletes the user's 'favorites' from the Favorite model" do
							expect {Favorite.find(user.id)}.to raise_error(ActiveRecord::RecordNotFound)
						end

						it "removes other user's 'favorites' associated w/ any polls created by the 'canceled' user" do
							expect {Favorite.find(@favorite1.id)}.to raise_error(ActiveRecord::RecordNotFound)
							expect {Favorite.find(@favorite2.id)}.to raise_error(ActiveRecord::RecordNotFound)
						end

						it "inactivates each of the user's images" do
							Image.find(@poll1.image_id).inactive.should == true
							Image.find(@poll1.image_id).inactive.should == true
						end

					end #context visitor wanst to cancel
				end #context someone has favorited users polls
			end #context favorites someone elses
		end #context created 2 polls
	end #context visitor login

end
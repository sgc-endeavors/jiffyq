require 'spec_helper'

describe "#Admin_Edit_Poll" do 
	
	subject{ page }

	context "administrator visits the site and logs in" do
		before(:each) do
			visit admin_root_path
			admin_user = FactoryGirl.create(:admin_user)
			image = FactoryGirl.create(:image)
			@poll = FactoryGirl.create(:poll, image_id: image.id, user_id: image.user_id)
			fill_in "admin_user_email", with: admin_user.email
		  fill_in "admin_user_password", with: admin_user.password
		  click_button "Login"
		  visit admin_polls_path
		end

		it "includes a list of the polls" do
			should have_content(@poll.question)
		end

		context "admin clicks on 'View'" do
			before(:each) { click_on "View" }

			it "routes the admin to the 'show' page and shows the poll's question" do
				current_path.should == admin_poll_path(@poll)
				should have_content(@poll.question)
			end
		end

		context "admin clicks on 'Edit'" do
			before(:each) { click_on "Edit" }

			it "routes the admin to the 'edit' page and shows the poll's question" do
				current_path.should == edit_admin_poll_path(@poll)
				should have_content("Edit Poll")
			end
			
			context "admin adjusts the question field and saves the change" do
				before(:each) do
					fill_in "Question", with: "Do I Rule?"
					click_on "Update Poll"
				end

				it "routes the user back to the admin_poll_index view" do
					current_path.should == admin_polls_path
				end
				it "successfully saves the changes" do
					should have_content("Do I Rule?")
				end
			end
		end

		context "admin clicks on 'Delete'" do
			before(:each) { click_on "Delete" }

			it "routes the admin back to the 'admin_poll_index' page after deleting the poll" do
				current_path.should == admin_polls_path
				should_not have_content(@poll.question)
			end

			context "their is a a corresponding image that must be deleted" do
				it "deletes the image as well if the author of the poll is also the image owner" do
					expect {Image.find(@poll.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
				end
			end

			context "their is not a corresponding image that must be deleted" do
				before(:each) do
					@image = FactoryGirl.create(:image)
					@poll.image_id = @image.id
					@poll.save!
				end

				it "does NOT delete the image" do
					Image.find(@poll.image_id).id.should == @image.id
				end
			end


		end
	end
end
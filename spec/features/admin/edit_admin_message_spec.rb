require 'spec_helper'

describe "#Admin_Edit_Message" do 
	
	subject{ page }

	context "administrator visits the site and logs in" do
		before(:each) do
			visit admin_root_path
			admin_user = FactoryGirl.create(:admin_user)
			image = FactoryGirl.create(:image)
			@message = FactoryGirl.create(:message, image_id: image.id, user_id: image.user_id)
			fill_in "admin_user_email", with: admin_user.email
		  fill_in "admin_user_password", with: admin_user.password
		  click_button "Login"
		  visit admin_messages_path
		end

		it "includes a list of the messages" do
			should have_content(@message.question)
		end

		context "admin clicks on 'View'" do
			before(:each) { click_on "View" }

			it "routes the admin to the 'show' page and shows the message's question" do
				current_path.should == admin_message_path(@message)
				should have_content(@message.question)
			end
		end

		context "admin clicks on 'Edit'" do
			before(:each) { click_on "Edit" }

			it "routes the admin to the 'edit' page and shows the message's question" do
				current_path.should == edit_admin_message_path(@message)
				should have_content("Edit Message")
			end
			
			context "admin adjusts the question field and saves the change" do
				before(:each) do
					fill_in "Question", with: "Do I Rule?"
					click_on "Update Message"
				end

				it "routes the user back to the admin_message_index view" do
					current_path.should == admin_messages_path
				end
				it "successfully saves the changes" do
					should have_content("Do I Rule?")
				end
			end
		end

		context "admin clicks on 'Delete'" do
			before(:each) { click_on "Delete" }

			it "routes the admin back to the 'admin_message_index' page after deleting the message" do
				current_path.should == admin_messages_path
				should_not have_content(@message.question)
			end

			context "their is a a corresponding image that must be deleted" do
				it "deletes the image as well if the author of the message is also the image owner" do
					expect {Image.find(@message.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
				end
			end

			context "their is not a corresponding image that must be deleted" do
				before(:each) do
					@image = FactoryGirl.create(:image)
					@message.image_id = @image.id
					@message.save!
				end

				it "does NOT delete the image" do
					Image.find(@message.image_id).id.should == @image.id
				end
			end


		end
	end
end
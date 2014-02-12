require 'spec_helper'

describe "#Admin_Edit_Poll" do 
	
	subject{ page }

	context "administrator visits the site and logs in" do
		let(:admin_user) { FactoryGirl.create(:admin_user) }
		let(:image) { FactoryGirl.create(:image) }

		before(:each) do
			log_in_as_admin(admin_user)
			@poll = FactoryGirl.create(:poll, image_id: image.id, user_id: image.user_id)			
		  visit admin_polls_path
		end

		it "includes a list of the poll questions" do
			should have_content(@poll.question)
		end

		context "admin clicks on 'View'" do
			before(:each) { click_on "View" }

			it "routes the admin to the 'admin_show' page and shows the poll's details" do
				current_path.should == admin_poll_path(@poll)
				should have_content(@poll.question)
			end
		end

		context "admin clicks on 'Edit'" do
			before(:each) { click_on "Edit" }

			it "routes the admin to the 'admin_edit' page and shows the poll's details" do
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
			it "deletes the image" do
				expect {Image.find(@poll.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
			end
		end
	end
end
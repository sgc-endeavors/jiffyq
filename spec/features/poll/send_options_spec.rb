require 'spec_helper'

describe "Poll#Send_Options_page" do 
	
	subject{ page }

	let(:poll_to_send) { FactoryGirl.create(:poll)}
	
	context "visitor has signed in" do
		before(:each) do
			sign_in_as_existing_user(poll_to_send.user)
			visit send_options_path(identifier: poll_to_send.identifier)
		end

		it { should have_link("Email") }
		it { should have_content("Text") }
		it { should have_content("Social Media") }
		it { should have_link("Return to Question") }
		it { should have_link("Create Another")}

		context "user wants to send as an email" do
			before(:each) { click_on "Send as Email" }
			# it should open a user's email application
		end

		context "user wants to leave this page" do
					
			context "user wants to view the poll just sent" do
				before(:each) { click_on "Return to Question" }

				it "takes user back to poll show page" do
					current_path.should == poll_path(poll_to_send.identifier)
				end	
			end

			context "user wants to create a new poll" do
				before(:each) { click_on "Create Another" }

				it "takes user to the images new view" do
					current_path.should == new_image_path
				end		
			end
		end
	end
end
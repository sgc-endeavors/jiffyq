require 'spec_helper'

describe "Message#Send_Options_page" do 
	
	subject{ page }

	let(:message_to_send) { FactoryGirl.create(:message)}
	
	context "visitor has signed in" do
		before(:each) do
			sign_in_as_existing_user(message_to_send.user)
			visit send_options_path(message_id: message_to_send.id)
		end

		it { should have_link("Send as Email") }
		it { should have_content("Send as Text") }
		it { should have_link("Return to Question") }
		it { should have_link("Create Another")}

		context "user wants to send as an email" do
			before(:each) { click_on "Send as Email" }
			# it should open a user's email application
		end

		context "user wants to leave this page" do
					
			context "user wants to view the message just sent" do
				before(:each) { click_on "Return to Question" }

				it "takes user back to message show page" do
					current_path.should == message_path(message_to_send.identifier)
				end	
			end

			context "user wants to create a new message" do
				before(:each) { click_on "Create Another" }

				it "takes user to the images new view" do
					current_path.should == new_image_path
				end		
			end
		end
	end

	context "visitor has not signed in" do
		before(:each) do
			visit send_options_path(message_id: message_to_send.id)
		end		

		it "routes the user to the sign in page" do
			current_path.should == new_user_session_path
		end
	end
end
require 'spec_helper'

describe "Message#Send_Options_page" do 
	
	subject{ page }

	let(:message_to_send) { FactoryGirl.create(:message)}
	
	before(:each) do
		visit send_options_path(message_id: message_to_send.id)
	end

	it { should have_link("Send as Email") }
	it { should have_link("Text on Android") }
	it { should have_content("Text on iPhone") }
	it { should have_link("Return to Message") }
	it { should have_link("Create New Message")}

	context "user wants to send as an email" do
		before(:each) { click_on "Send as Email" }
		# it should open a users email application
	end


	context "user wants to leave this page" do
				
		context "user wants to view the message just sent" do
			before(:each) { click_on "Return to Message" }

			it "takes user back to message show page" do
				current_path.should == message_path(message_to_send.id)
			end	
		end

		context "user wants to create a new message" do
			before(:each) { click_on "Create New Message" }

			it "takes user to the images new view" do
				current_path.should == new_image_path
			end		
		end
	end

end
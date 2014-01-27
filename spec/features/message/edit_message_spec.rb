require 'spec_helper'

describe "Message#Edit_page" do 
	let(:draft_message) { FactoryGirl.create(:message) }
	
	subject{ page }
	
	context "in the address bar, visitor types in '/edit' on an already sent message" do
		let(:sent_message) { FactoryGirl.create(:message, status: "sent") }

		before(:each) { visit edit_message_path(sent_message) }
		it "routes the visitor to the 'login' page rather than the 'edit' page" do
			current_path.should == new_user_session_path
		end
	end

	context "in the address bar, user types in '/edit' on an already sent message" do
		let(:sent_message) {FactoryGirl.create(:message, status: "sent")}
		before(:each) do
			sign_in_as_existing_user(sent_message.user)
			visit edit_message_path(sent_message)
		end
		it "routes the user to the 'show' page rather than the 'edit' page" do
			current_path.should == message_path(sent_message)
		end
	end

	context "user presses 'Edit' " do
		before(:each) do
			sign_in_as_existing_user(draft_message.user)
			visit edit_message_path(draft_message)
		end

		it "displays the draft message info in the form" do
			should have_field("message_button1", with: "Yes I am!")
			#not testing any other fields... one is sufficient
		end

		context "user updates message and presses 'Preview'" do
			before(:each) do
				update_draft_message
				click_on "Preview"
			end

			it "successfully saves the updates to the message" do
				updated_draft_message = Message.find(draft_message.id)
				updated_draft_message.question.should == "Am I more bad ass than Gerard?"
			end

			it "routes the user back to the show page" do
				current_path.should == message_path(draft_message)
			end
		end
	end
end
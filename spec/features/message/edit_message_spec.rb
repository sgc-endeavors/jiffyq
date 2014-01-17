require 'spec_helper'

describe "Message#Edit_page" do 
	let(:draft_message) {FactoryGirl.create(:message)}
	
	subject{ page }

	
	context "user types in /edit on an already sent message" do
		let(:sent_message) {FactoryGirl.create(:message, status: "sent")}
		before(:each) { visit edit_message_path(sent_message) }
		it "routes the user to the show page rather than the edit page" do
			current_path.should == message_path(sent_message)
		end
	end


	context "author pressed 'Edit Message' " do
		before(:each) do
			visit edit_message_path(draft_message)
		end

		it "displays the draft message info in the form" do
			should have_field("message_question", with: "Am I Cooler Than Gerard?")
			#not testing any other fields... one is sufficient
		end

		context "author updates message and presses 'Update'" do
			it "successfully saves the updates" do
				update_draft_message
				click_on "Update"
				updated_draft_message = Message.find(draft_message.id)
				updated_draft_message.question.should == "Am I more bad ass than Gerard?"
			end

			it "routes the user back to the show page" do
				click_on "Update"
				should have_content("Am I Cooler Than Gerard?")
				current_path.should == message_path(draft_message)
			end
		end
	end

	# context "author pressed 'Send Message' " do
	# 	before(:each) do
	# 		visit edit_message_path(draft_message, send_status: "send")
	# 	end

	# 	xit "sends the message" do
	# 	end

	# 	it "updates the status" do
			
	# 	end

	# 	it "routes the user back to the show page" do
	# 		should have_content("-o-Meter")
	# 		current_path.should == message_path(draft_message)
	# 	end
	# end

end
require 'spec_helper'

describe "Poll#Edit_page" do 
	
	subject{ page }
	
	context "a poll has already been created and sent" do
		let(:sent_poll) { FactoryGirl.create(:poll, status: "sent") }
		context "visitor types in '/edit' for an 'already-sent' poll" do
			before(:each) { visit edit_poll_path(sent_poll) }
			
			it "routes the visitor to the 'login' page" do
				current_path.should == new_user_session_path	
			end
		end
		context "visitor logs in" do
			before(:each) { sign_in_as_existing_user(sent_poll.user) }
			context "visitor types in '/edit' for an 'already-sent' poll" do
				before(:each) { visit edit_poll_path(sent_poll) }
				
				it "routes the user to the 'show' page rather than the 'edit' page" do
					current_path.should == poll_path(sent_poll)
				end
			end
		end
	end

	context "a poll has NOT YET been sent" do
		let(:draft_poll) { FactoryGirl.create(:poll) }
		context "visitor has signed in" do
			before(:each) { sign_in_as_existing_user(draft_poll.user) }
			context "user types in '/edit' in the URL for the related poll" do
				before(:each) { visit edit_poll_path(draft_poll) }
				
				it "displays the draft poll info in the form" do
					should have_field("poll_button1", with: "Yes I am!")
					#not testing any other fields... one is sufficient
				end

				context "user updates poll and presses 'Preview'" do
					before(:each) do
						update_draft_poll
						click_on "Preview"
					end
					
					it "successfully saves the updates to the poll" do
						updated_draft_poll = Poll.find(draft_poll.id)
						updated_draft_poll.question.should == "Am I more bad ass than Gerard?"
					end

					it "routes the user back to the show page" do
						current_path.should == poll_path(draft_poll)
					end
				end
			end
		end	
	end
end
require "spec_helper"

describe "Message#Show_page" do 
	
	subject{ page }

	context "the message is in being previewed by the author" do
		let(:drafted_message) { FactoryGirl.create(:message)}
		before(:each) do
			visit message_path(drafted_message.id)
		end

		it "shows a link to 'Send'" do
			should have_link("Send")
		end

		it "shows a link to 'edit message'" do
			should have_link("Edit Message")
		end
		
		it "does not show 'Forward' or 'Create New' links" do	
			click_on "#{drafted_message.button1}"
			should_not have_link("Forward")
			should_not have_link("Create New")
		end

		context "author wants to send the message" do
			before(:each) { click_on "Send" }
			it "routes the author to the 'send options view'" do
				current_path.should == send_options_path  ##### We cant test the full path which would be send_options_path(message_id: drafted_message.id).  How do you do this?
				should have_content("Send Options")
			end			
			
			it "saves the message status to sent" do
				Message.find(drafted_message.id).status.should == "sent"
			end
		end

		context "author wants to further edit the message" do
			before(:each) { click_on "Edit Message" }
			it "routes the author to the edit page" do
				current_path.should == edit_message_path(drafted_message)
			end
		end
	end

	context "the message was sent by the author" do
		let(:sent_message) { FactoryGirl.create(:message, status: "sent")}
		before(:each) do
			visit message_path(sent_message.id)
		end

		context "message recipient opens message for the first time" do		
			it "shows the message details" do
				should have_content("#{sent_message.question}")
				should have_link("#{sent_message.button1}")
				should have_link("#{sent_message.button2}")
				should_not have_content("#{sent_message.response1}")
				should_not have_content("#{sent_message.response2}")
				should_not have_link("Forward")
				should_not have_link("Create New")
				should_not have_link("Send")
				should_not have_link("Edit Message")
			end
		end

		context "message recipient clicks on 'button1' " do		
			it "shows response1" do
				click_on "#{sent_message.button1}"
				should have_content("#{sent_message.response1}")
				should have_link("Forward")
				should have_link("Create New")

			end
		end

		context "message recipient clicks on 'button2' " do		
			it "shows response2" do
				click_on "#{sent_message.button2}"
				should have_content("#{sent_message.response2}")
				should have_link("Forward")
				should have_link("Create New")
			end
		end

		context "message recipient pressed button1 or button2" do
			before(:each) { click_on "#{sent_message.button1}" }

			context "message recipient preessed 'Forward'" do
				before(:each) { click_on "Forward" }

				it "routes the user to the message#new view" do
					current_path.should == new_message_path 
				end
			end
		end
	end

end
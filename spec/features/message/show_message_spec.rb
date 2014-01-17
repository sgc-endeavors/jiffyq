require "spec_helper"

describe "Message#Show_page" do 
	
	subject{ page }

	context "the message is in being previewed by the author" do
		let(:drafted_message) { FactoryGirl.create(:message)}
		before(:each) do
			visit message_path(drafted_message.id)
		end

		it "shows a link to 'send message'" do
			should have_link("Send Message")
		end

		it "shows a link to 'edit message'" do
			should have_link("Edit Message")
		end
		
		it "does not show 'Forward' or 'Create New' links" do	
			click_on "#{drafted_message.button1}"
			should_not have_link("Forward") #####
			should_not have_link("Create New")
		end

		context "author wants to send the message" do
			it "routes the author to the edit page w/ send parameters" do
				click_on "Send Message"
				current_path.should == message_path(drafted_message)
			end

			it "changes the status of the message to 'sent'" do
				click_on "Send Message"
				Message.find(drafted_message.id).status.should == "sent"
			end


		end

		context "author wants to further edit the message" do
			it "routes the author to the edit page" do
				click_on "Edit Message"
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
				should_not have_link("Send Message")
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
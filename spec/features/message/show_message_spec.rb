require "spec_helper"

describe "Message#Show_page" do 
	let(:existing_message) { FactoryGirl.create(:message)}
	before(:each) do
		visit message_path(existing_message.id)
	end

	subject{ page }

	context "surveyor previews their message" do
		it "shows a link to 'send message'" do
			should have_link("Send Message")
		end
		it "shows a link to 'edit message'" do
			should have_link("Edit Message")
		end
	end
	context "message recipient opens message for the first time" do		
		it "shows the message details" do
			within("h1") { should have_content("#{existing_message.title}-o-Meter") }
			should have_content("#{existing_message.question}")
			should have_link("#{existing_message.button1}")
			should have_link("#{existing_message.button2}")
			should_not have_content("#{existing_message.response1}")
			should_not have_content("#{existing_message.response2}")
			should_not have_link("Forward")
			should_not have_link("Create New")
			should_not have_link("Send Message")
			should_not have_link("Edit Message")
		end
	end

	context "message recipient clicks on 'button1' " do		
		it "shows response1" do
			click_on "#{existing_message.button1}"
			should have_content("#{existing_message.response1}")
			should have_link("Forward")
			should have_link("Create New")

		end
	end

	context "message recipient clicks on 'button2' " do		
		it "shows response2" do
			click_on "#{existing_message.button2}"
			should have_content("#{existing_message.response2}")
			should have_link("Forward")
			should have_link("Create New")
		end
	end

	context "message recipient pressed button1 or button2" do
		before(:each) { click_on "#{existing_message.button1}" }

		context "message recipient preessed 'Forward'" do
			before(:each) { click_on "Forward" }

			it "routes the user to the message#new view" do
				current_path.should == new_message_path 
			end
		end
	end



end
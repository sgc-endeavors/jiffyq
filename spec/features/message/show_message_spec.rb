require "spec_helper"

describe "Message#Show_page" do 
	
	subject{ page }

	context "the message is being previewed by the author" do
		let(:drafted_message) { FactoryGirl.create(:message)}
		before(:each) do
			sign_in_as_existing_user(drafted_message.user)
			visit message_path(drafted_message.identifier)
		end

		it "shows a link to 'Save & Send'" do
			should have_link("Save & Send")
		end

		it "shows a link to 'Edit'" do
			should have_link("Edit")
		end
		
		it "does NOT show 'Forward' or 'Create New' links" do	
			click_on "#{drafted_message.button1}"
			should_not have_link("Forward")
			should_not have_link("Create Your Own")
		end

		context "user wants to send the message they've authored" do
			before(:each) { click_on "Save & Send" }
			it "routes the user to the 'send options' view'" do
				current_path.should == send_options_path  ##### We cant test the full path which would be send_options_path(message_id: drafted_message.id).  How do you do this?
				should have_content("Send Options")
			end			
			
			it "saves the message status to sent" do
				Message.find(drafted_message.id).status.should == "sent"
			end
		end

		context "author wants to further edit the message" do
			before(:each) { click_on "Edit" }
			it "routes the author to the edit page" do
				current_path.should == edit_message_path(drafted_message)
			end
		end
	end

	context "the message was sent by the author" do
		let(:sent_message) { FactoryGirl.create(:message, status: "sent")}
		before(:each) do
			sign_in_as_existing_user(sent_message.user)
			visit message_path(sent_message)
		end
		context "the author wants to simply forward the message" do
			it "shows the forward link" do
				should have_link("Forward")
			end	
			context "the author presses forward" do
				before(:each) { click_on "Forward"}
				
				it "routes the author to the send options page" do
					current_path.should == send_options_path
				end
			end
		end
	end
	context "the message was sent by the author" do
		# context "the image for the question was destroyed" do
		# 	let(:sent_message) { FactoryGirl.create(:message, image_id: 99999, status: "sent")}
				
		# 	before(:each) do
		# 		visit message_path(sent_message)
		# 	end

		# 	it 'shows an alternative placeholder image' do
		# 		should have_css("img", text: "/the_bomb.png")
		# 	end
		# end

		# The above is testing to confirm that the alternative photo is provided when
		#the original image was destroyed by the image owner.  This portion of the 
		#test is not working.

			context "the image for the question was not destroyed" do
				let(:sent_message) { FactoryGirl.create(:message, status: "sent")}
				before(:each) do
					visit message_path(sent_message)
				end

				context "message recipient opens message and is not logged in" do		
					it "shows the message details" do
						should have_css("img", text: sent_message.image.s3_image_loc)
						should have_content("#{sent_message.question}")
						should have_link("#{sent_message.button1}")
						should have_link("#{sent_message.button2}")
						should_not have_content("#{sent_message.response1}")
						should_not have_content("#{sent_message.response2}")
						should_not have_link("Forward")
						should_not have_link("Create Your Own")
						should_not have_link("Save & Send")
						should_not have_link("Edit")
					end

				context "message recipient clicks on 'button1' " do		
					it "shows response1" do
						click_on "#{sent_message.button1}"
						should have_content("#{sent_message.response1}")
						should have_link("Forward")
						should have_link("Create Your Own")
					end
				end

				context "message recipient clicks on 'button2' " do		
					it "shows response2" do
						click_on "#{sent_message.button2}"
						should have_content("#{sent_message.response2}")
						should have_link("Forward")
						should have_link("Create Your Own")
					end
				end

				context "message recipient pressed button1 or button2" do
					before(:each) { click_on "#{sent_message.button1}" }

					context "message recipient pressed 'Forward'" do
						before(:each) { click_on "Forward" }

						it "routes the user to the 'login' page" do
							current_path.should == new_user_session_path 
						end
					end
				end
			end
		end
	end

end
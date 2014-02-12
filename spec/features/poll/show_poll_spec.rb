require "spec_helper"

describe "Poll#Show_page" do 
	
	subject{ page }

	context "the user is an author of a drafted poll and has signed in" do
		let(:drafted_poll) { FactoryGirl.create(:poll) }
		before(:each) { sign_in_as_existing_user(drafted_poll.user) }
		
		context "the user has authored a poll and is previewing it" do
			before(:each) { visit poll_path(drafted_poll.identifier) }
			it "shows a link to 'Save & Send' and 'Edit'" do
				should have_link("Save & Send")
				should have_link("Edit")
			end
			
			context "author clicks on an answer button" do
				before(:each) { click_on "#{drafted_poll.button1}" }
				
				it "does NOT show 'Forward' or 'Create New' links" do		
					should_not have_link("Forward")
					should_not have_link("Create Your Own")
				end
			end
			
			context "user wants to send the poll they've authored" do
				before(:each) { click_on "Save & Send" }
				it "routes the user to the 'send options' view'" do
					current_path.should == send_options_path  ##### We cant test the full path which would be send_options_path(poll_id: drafted_poll.id).  How do you do this?
					should have_content("Share Your JiffyPoll")
				end			
				
				it "saves the poll status to sent" do
					Poll.find(drafted_poll.id).status.should == "sent"
				end
			end

			context "author wants to further edit the poll" do
				before(:each) { click_on "Edit" }
				it "routes the author to the edit page" do
					current_path.should == edit_poll_path(drafted_poll)
				end
			end
		end

		context "the poll was sent by the author" do
			let(:sent_poll) { FactoryGirl.create(:poll, status: "sent")}
			before(:each) { visit poll_path(sent_poll) }

			context "the author wants to simply forward the poll" do
			
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
	end

	context "the poll was sent by the author" do
		let(:sent_poll) { FactoryGirl.create(:poll, status: "sent")}
	
		context "poll recipient opens poll and is not logged in" do		
			before(:each) do
				visit poll_path(sent_poll)
			end

			it "shows the poll details" do
				should have_css("img", text: sent_poll.image.s3_image_loc)
				should have_content("#{sent_poll.question}")
				should have_link("#{sent_poll.button1}")
				should have_link("#{sent_poll.button2}")
				should have_link("Report a Problem")
			end

			it "does NOT show any of the responses or links to forward, create, add, etc. yet" do
				should_not have_content("#{sent_poll.response1}")
				should_not have_content("#{sent_poll.response2}")
				should_not have_link("Forward")
				should_not have_link("Create Your Own")
				should_not have_link("Save & Send")
				should_not have_link("Edit")
			end

			context "poll recipient clicks on 'button1' " do		
				before(:each) { click_on "#{sent_poll.button1}" }

				it "shows response1" do
					should have_content("#{sent_poll.response1}")
				end

				it "shows the various links to forward, create, add, etc." do
					should have_link("Forward")
					should have_link("Create Your Own")
					should have_link("Add to Favorites")
					should have_link("Report a Problem")
				end
			end

			context "poll recipient clicks on 'button2' " do		
				before(:each) { click_on "#{sent_poll.button2}" }	

				it "shows response2" do
					should have_content("#{sent_poll.response2}")
				end

				it "shows the various links to forward, create, add, etc." do
					should have_link("Forward")
					should have_link("Create Your Own")
					should have_link("Add to Favorites")
				end
			end
			
			context "poll recipient pressed button1 or button2" do
				before(:each) { click_on "#{sent_poll.button1}" }
					
				context "poll recipient pressed 'Forward'" do
					before(:each) { click_on "Forward" }

					it "routes the user to the 'send_options' page" do
						current_path.should == send_options_path 
					end
				end

				context "poll recipient has not signed in and presses 'Add to Favorites'" do
					before(:each) do 
						click_on "Add to Favorites" 
					end

					it "routes the user back to the sign_in page" do
						current_path.should == new_user_session_path
					end
				end
			end
		end

		context "poll recipient opens poll and is logged in" do		
			let(:user) { FactoryGirl.create(:user)}
			before(:each) { sign_in_as_existing_user(user) }
			
			context "poll recipient opens the sent poll and clicks an answer button" do
				before(:each) do 
					visit poll_path(sent_poll) 
					click_on "#{sent_poll.button1}"
				end
				
				context "poll recipient has already saved the poll as a favorite" do
					before(:each) do
						favorite = Favorite.new
						favorite.user_id = user.id
						favorite.poll_id = sent_poll.id
						favorite.save!
						visit poll_path(sent_poll) 
						click_on "#{sent_poll.button1}"
					end
					it { should_not have_link("Add to Favorites") }
				end

				context "poll recipient has NOT already saved the poll as a favorite" do
					it { should have_link("Add to Favorites") }
				
					context "poll recipient clicks to 'Add to Favorites'" do
						before(:each) { click_on "Add to Favorites" }

						it "saves the poll as the user's favorite" do
							favorite = Favorite.last
							favorite.user_id.should == user.id
							favorite.poll_id.should == sent_poll.id
						end
						
						it "routes the user back to the index page" do
							current_path.should == polls_path
						end
					end		
				end	
			end
		end
	end
end
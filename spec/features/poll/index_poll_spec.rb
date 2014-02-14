require "spec_helper"

describe "Poll#Index_page" do 
	subject{ page }

	context "the visitor has logged into their account" do
		let(:user) { FactoryGirl.create(:user)}
		before(:each) do
			sign_in_as_existing_user(user)
			@users_poll = FactoryGirl.create(:poll, user_id: user.id)
			#original_favorite = FactoryGirl.create(:favorite, poll_id: @original_poll.id)
			@someone_elses_poll = FactoryGirl.create(:poll, question:  "Am I more dumber than Gerard?")
			@favorite = FactoryGirl.create(:favorite, poll_id: @someone_elses_poll.id, user_id: user.id)	 
			visit polls_path
		end

		describe "Favorites Section" do

			it "has a header called 'My Favorites' " do
				should have_content("My Favorites")
			end	

			it "has links to the individual's favorites" do
				should have_link("Am I more dumber than Gerard?")
			end

			it "has a button to remove the poll as a favorite" do
				should have_link("x")
			end

			context "user presses the 'Remove' button to remove the poll as a favorite" do
				before(:each) { click_on "x" }
			
				it "removes the poll as a favorite" do
					should_not have_content("Am I more dumber than Gerard?")
					expect {Favorite.find(@favorite.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "routes the user back to the poll_index page after removing the favorite" do
					current_path.should == polls_path				
				end
			end
		end

		describe "My Polls Section" do

			it "has a header called 'My Polls'" do
				should have_content("My Polls")
			end

			it "has links to the user's questions" do
				should have_link("Am I Cooler Than Gerard?")
			end

			context "the author visits the 'show' page for his own poll" do
				before(:each) { visit poll_path(@users_poll) }
				
				context "the author visits the index page" do
					before(:each) { visit polls_path }

					it "does not count the authors visit as a page view" do
						should have_content("Am I Cooler Than Gerard? (0)")
					end
				end
			end

			context "the author visits the 'show' page for someone else's poll" do
				before(:each) { visit poll_path(@someone_elses_poll) }

				it "adds +1 to the page views for that poll" do
					Poll.find(@someone_elses_poll.id).page_views.should == 1
				end
			end

			it "has a delete button" do
				should have_link("X")
			end

			context "user presses the delete button" do
				before(:each) { click_on "X" }
			
				it "removes the poll" do
					should_not have_content("Am I Cooler Than Gerard?")
					expect {Poll.find(@users_poll.id)}.to raise_error(ActiveRecord::RecordNotFound)
				end

				it "removes the related image from the database" do
					expect {Image.find(@users_poll.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
				end
			
				it "routes the user back to the poll_index page" do
					current_path.should == polls_path				
				end
			end
		end
	end
end
require "spec_helper"

describe "Poll#Index_page" do 
	
	subject{ page }

	context "the user has logged into their account" do
		let(:user) { FactoryGirl.create(:user)}
		before(:each) do
			sign_in_as_existing_user(user)
			@original_poll = FactoryGirl.create(:poll, user_id: user.id)
			@new_poll1 = FactoryGirl.create(:poll, question:  "Am I more dumber than Gerard?")
			@new_favorite = FactoryGirl.create(:favorite, poll_id: @new_poll1.id, user_id: user.id)
			 
			visit polls_path
		end

		it "has a header called 'My Favorites' " do
			should have_content("My Favorites")
		end	

		it "has links to the individual's favorites" do
			should have_link("Am I more dumber than Gerard?")
		end

		it "has a delete button" do
			should have_link("Remove")
		end




		context "user presses the 'Remove' button" do
			before(:each) { click_on "Remove" }
		
			it "removes the poll as a favorite" do
				should_not have_content("Am I more dumber than Gerard?")
				expect {Favorite.find(@new_favorite.id)}.to raise_error(ActiveRecord::RecordNotFound)
			end

			it "routes the user back to the poll_index page" do
				current_path.should == polls_path				
			end
		end









		it "has a header called 'My Questions'" do
			should have_content("My Polls")
		end

		it "has links to the user's questions" do
			should have_link("Am I Cooler Than Gerard?")
		end

		context "no one has visited the 'show' page for this poll" do
			it "shows page view count equal to 0" do
			should have_content("Am I Cooler Than Gerard? (0)")
			end
		end

		context "the author visits the 'show' page for his own poll" do
			before(:each) do
				visit poll_path(@original_poll)
				visit polls_path
			end

			it "shows page view count equal to 0" do
				should have_content("Am I Cooler Than Gerard? (0)")
			end
		end


		context "the author visits the 'show' page for someone else's poll" do
			before(:each) do
				visit poll_path(@new_poll1)
			end

			it "adds +1 to the page views for that poll" do
				Poll.find(@new_poll1.id).page_views.should == 1
			end
		end

		it "has a delete button" do
			should have_link("Delete")
		end

		context "user presses the delete button" do
			before(:each) { click_on "Delete" }
		
			context "the poll being deleted had an original image" do
				it "removes the related image from the database" do
					expect {Image.find(@original_poll.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
				end
			end

			it "removes the poll" do
				should_not have_content("Am I Cooler Than Gerard?")
				expect {Poll.find(@original_poll.id)}.to raise_error(ActiveRecord::RecordNotFound)
			end

			it "routes the user back to the poll_index page" do
				current_path.should == polls_path				
			end
		end
	end
end
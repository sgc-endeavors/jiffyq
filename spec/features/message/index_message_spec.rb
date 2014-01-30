require "spec_helper"

describe "Message#Index_page" do 
	
	subject{ page }

	context "the user has logged into their account" do
		let(:user) { FactoryGirl.create(:user)}
		before(:each) do
			sign_in_as_existing_user(user)
			@original_message = FactoryGirl.create(:message, user_id: user.id)
			@new_message1 = FactoryGirl.create(:message, origin_message: @original_message.id)
			@new_message2 = FactoryGirl.create(:message, origin_message: @original_message.id) 
			visit messages_path
		end

		it "has a header called 'My Questions'" do
			should have_content("My Questions")
		end

		it "has links to the user's questions" do
			should have_link("Am I Cooler Than Gerard?")
		end

		context "no one has visited the 'show' page for this message" do
			it "shows page view count equal to 0" do
			should have_content("Am I Cooler Than Gerard? (0)")
			end
		end

		context "the author visits the 'show' page for his own message" do
			before(:each) do
				visit message_path(@original_message)
				visit messages_path
			end

			it "shows page view count equal to 0" do
				should have_content("Am I Cooler Than Gerard? (0)")
			end
		end


		context "the author visits the 'show' page for someone else's message" do
			before(:each) do
				visit message_path(@new_message1)
			end

			it "adds +1 to the page views for that message" do
				Message.find(@new_message1.id).page_views.should == 1
			end
		end

		it "has a delete button" do
			should have_link("X")
		end

		context "user presses the delete button" do
			before(:each) { click_on "X" }
		
			context "the message being deleted had an original image" do
				it "removes the related image from the database" do
					expect {Image.find(@original_message.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
				end
			end

			it "removes the message" do
				should_not have_content("Am I Cooler Than Gerard?")
				expect {Message.find(@original_message.id)}.to raise_error(ActiveRecord::RecordNotFound)
			end

			it "routes the user back to the message_index page" do
				current_path.should == messages_path				
			end
		end
	end
end
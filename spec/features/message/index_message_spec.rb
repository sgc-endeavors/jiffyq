require "spec_helper"

describe "Message#Index_page" do 
	
	subject{ page }

	context "the author has logged into their account" do
		let(:user) { FactoryGirl.create(:user)}
		before(:each) do
			sign_in_as_existing_user(user)
			@original_message = FactoryGirl.create(:message, user_id: user.id)
			2.times { FactoryGirl.create(:message, origin_message: @original_message.id) }
			visit messages_path
		end

		it "has title header for all my questions" do
			should have_content("My Questions")
		end

		it "has links to the author's messages" do
			should have_link("Am I Cooler Than Gerard?")
		end

		it "shows the activity spawned by the message" do
			should have_content("Am I Cooler Than Gerard? (2)")
		end

		it "has a delete button" do
			should have_link("X")
		end

		context "user presses the delete button" do
			before(:each) { click_on "X" }
		
			context "the message being deleted had an original image" do
				it "removes the related image from amazon s3" do
					
				end
			end



			it "removes the message" do
				current_path.should == messages_path
				should_not have_content("Am I Cooler Than Gerard? (2)")
			end

			

		end



	end
end
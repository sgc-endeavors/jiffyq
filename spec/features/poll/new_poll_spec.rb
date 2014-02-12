require "spec_helper"

describe "Poll#New_page" do 
	let(:existing_poll) { FactoryGirl.create(:poll) }
	let(:new_poll) { FactoryGirl.build(:poll) }
	before(:each) { sign_in_as_existing_user(new_poll.user) }

	subject{ page }

	context "user creates a new poll after having first created an image" do
		before(:each) { visit new_poll_path(image_id: new_poll.image.id) }

		#it should have an image of the image just uploaded  <--- How to test?
		it { should have_field("poll_question") }
		it { should have_field("poll_button1") }
		it { should have_field("poll_button2") }
		it { should have_field("poll_response1") }
		it { should have_field("poll_response2") }
		it { should have_button("Preview")}
		
		context "user presses 'Preview'" do
			before(:each) { preview_a_new_poll(new_poll) }

			it "save the new poll" do
				Poll.last.question.should == new_poll.question
				Poll.last.user_id.should == new_poll.user.id
				#chose to test the save of only 2 of the attributes
			end

			it "creates a unique string identifier in place of id for use in URL" do
				Poll.last.identifier.length.should == 8
			end
		end
	end

	context "user visits new_poll_path directly without first creating an image" do
		before(:each) { visit new_poll_path }
	
		it "routes the user back to the new_image_path" do
			current_path.should == new_image_path
		end
	end
end





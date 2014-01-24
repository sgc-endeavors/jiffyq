require "spec_helper"

describe "Message#New_page" do 
	let(:existing_message) {FactoryGirl.create(:message)}
	let(:new_message) { FactoryGirl.build(:message)}
	

	subject{ page }


	context "author visits website to create a new message after first creating an image" do
		before(:each) do
			sign_in_as_existing_user(new_message.user)
			visit new_message_path(image_id: new_message.image.id)
		end

		#xit { should have_field("message_image_id", with: 1 ) }
		it { should have_field("message_question") }
		it { should have_field("message_button1") }
		it { should have_field("message_button2") }
		it { should have_field("message_response1") }
		it { should have_field("message_response2") }
		it { should have_button("Save & Preview")}
		

		context "author presses 'Save & Preview'" do
			before(:each) { preview_a_new_message(new_message) }
			
			it "save the new message as a draft with the following attributes" do
				Message.last.question.should == new_message.question
				Message.last.user_id.should == new_message.user.id
			end

			it "creates a unique string identifier in place of id for use in URL" do
				Message.last.identifier.length.should == 8
			end

			it "assigns message id as origin_message id to identify a new string of messages" do
				Message.last.origin_message.should == Message.last.id
			end
		end
	end



	context "author visits new_message_path directly without first creating an image" do
		before(:each) do
			sign_in_as_existing_user(new_message.user)
			visit new_message_path
		end

		it "routes the author back to the new_image_path" do
			current_path.should == new_image_path
		end
	end













	context "message recipient logs in and clicks to forward an existing message" do
		before(:each) do
			sign_in_as_existing_user(existing_message.user)
			visit new_message_path(origin_id: existing_message.id, type: "existing")
		end
	
		#xit { should have_field("message_image", with: existing_message.image)}
		it { should have_field("message_question", with: existing_message.question)}
		it { should have_field("message_button1", with: existing_message.button1)}
		it { should have_field("message_button2", with: existing_message.button2)}
		it { should have_field("message_response1", with: existing_message.response1)}
		it { should have_field("message_response2", with: existing_message.response2)}

		context "author clicks 'Save & Preview'" do
			before(:each) { click_on "Save & Preview" }

			it "saves forwarded message origin_message value in the new message's origin_message field" do
				Message.last.origin_message.should == existing_message.origin_message
			end
		end
	end
end





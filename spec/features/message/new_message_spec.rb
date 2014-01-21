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

		xit { should have_field("message_image_id", with: 1 ) }
		it { should have_field("message_question") }
		it { should have_field("message_button1") }
		it { should have_field("message_button2") }
		it { should have_field("message_response1") }
		it { should have_field("message_response2") }
		it { should have_button("Preview")}
		

		context "author presses Preview" do
			before(:each) { preview_a_new_message(new_message) }
			
			it "save the new message as a draft" do
				Message.last.question.should == new_message.question
			end

			it "save the new message as a draft" do
				Message.last.user_id.should == new_message.user.id
			end

			it "generates and saves the new message's identifier" do
				Message.last.identifier.length.should == 8
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
	end


	context "message recipient clicks to Create a new message" do
		before(:each) do
			visit new_message_path(origin_id: existing_message.id, type: "new")
		end
	
		
		#xit { should_not have_field("message_image", with: existing_message.image)}
		it { should_not have_field("message_question", with: existing_message.question)}
		it { should_not have_field("message_button1", with: existing_message.button1)}
		it { should_not have_field("message_button2", with: existing_message.button2)}
		it { should_not have_field("message_response1", with: existing_message.response1)}
		it { should_not have_field("message_response2", with: existing_message.response2)}
		it { should_not have_field("message_address", with: existing_message.address)}
	end



end
require "spec_helper"

describe "Message#New_page" do 
	let(:existing_message) {FactoryGirl.create(:message)}
	let(:new_message) { FactoryGirl.build(:message)}
	

	subject{ page }


	context "visitor visits website to create a new message" do
		before(:each) do
			visit new_message_path
		end

		it { should have_field("message_title") }
		it { should have_field("message_image") }
		it { should have_field("message_question") }
		it { should have_field("message_button1") }
		it { should have_field("message_button2") }
		it { should have_field("message_response1") }
		it { should have_field("message_response2") }
		it { should have_field("message_address") }
		it { should have_button("Submit")}
		

		context "user presses submit" do
			before(:each) { submit_a_new_message(new_message) }
			
			it "should submit and save the new message" do
				Message.last.title.should == new_message.title
			end
		end
	end

	context "message recipient clicks to forward an existing message" do
		before(:each) do
			visit new_message_path(origin_id: existing_message.id, type: "existing")
		end
	
		it { should have_field("message_title", with: existing_message.title)}
		xit { should have_field("message_image", with: existing_message.image)}
		it { should have_field("message_question", with: existing_message.question)}
		it { should have_field("message_button1", with: existing_message.button1)}
		it { should have_field("message_button2", with: existing_message.button2)}
		it { should have_field("message_response1", with: existing_message.response1)}
		it { should have_field("message_response2", with: existing_message.response2)}
		it { should have_field("message_address", with: existing_message.address)}
	end


	context "message recipient clicks to Create a new message" do
		before(:each) do
			visit new_message_path(origin_id: existing_message.id, type: "new")
		end
	
		it { should_not have_field("message_title", with: existing_message.title)}
		xit { should_not have_field("message_image", with: existing_message.image)}
		it { should_not have_field("message_question", with: existing_message.question)}
		it { should_not have_field("message_button1", with: existing_message.button1)}
		it { should_not have_field("message_button2", with: existing_message.button2)}
		it { should_not have_field("message_response1", with: existing_message.response1)}
		it { should_not have_field("message_response2", with: existing_message.response2)}
		it { should_not have_field("message_address", with: existing_message.address)}
	end



end
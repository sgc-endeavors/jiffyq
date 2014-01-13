require "spec_helper"

describe "Image#New_page" do 
	let(:new_image) { FactoryGirl.build(:image)}
	

	subject{ page }


	context "visitor visits website to upload a new image" do
		before(:each) do
			visit new_image_path
		end

		it { should have_field("image_s3_image_key") }
		it { should have_button("Submit")}
		
		context "user presses submit" do
			it "routes user to the create new message path" do
				click_on "Submit"
				current_path.should == new_message_path
			end
		end

	end

end
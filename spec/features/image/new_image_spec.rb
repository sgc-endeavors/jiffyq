require "spec_helper"

describe "Image#New_page" do 
	let(:user) { FactoryGirl.create(:user) }
	let(:new_image) { FactoryGirl.build(:image)}
	

	subject{ page }


	context "visitor logs in and visits website to upload a new image" do
		before(:each) do
			sign_in_as_existing_user(user)
			visit new_image_path
		end

		it { should have_field("image_s3_image_loc") }
		it { should have_button("Upload")}
		
		context "user presses Upload" do
			it "routes user to the create new message path" do
				click_on "Upload"
				current_path.should == new_message_path
			end
		end

	end

end
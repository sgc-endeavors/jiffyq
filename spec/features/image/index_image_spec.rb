require 'spec_helper'

describe "Image#Index_page" do 
	
		
	subject{ page }
		
	context "user is an admin" do
		let(:admin_user) { FactoryGirl.create(:user, is_admin: true) }

		before(:each) do
			sign_in_as_existing_user(admin_user)
			@image = FactoryGirl.create(:image)
			visit images_path
		end

		it "has a header called 'List of Images'" do
			should have_content("List of Images")
		end

		xit "shows the image's storage path" do
			should have_content("MyString")
		end

		it "shows the image's id " do
			should have_content(@image.id)
		end

		it "has a delete button" do
			should have_link("X")
		end
	
		context "user presses the delete button" do
			before(:each) { click_on "X" }

			xit "deletes the selected_image" do
				should_not have_content(@image.id)

			end

		end

	end


	context "user is NOT an admin" do
		let(:non_admin_user) { FactoryGirl.create(:user) }

		before(:each) do
			sign_in_as_existing_user(non_admin_user)
			visit images_path
		end

		it "routes the user to the landing_page" do
			current_path.should == landing_page_path
		end
	end








end
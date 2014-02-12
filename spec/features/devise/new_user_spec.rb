require 'spec_helper'

describe "Devise#user_sign_up_page" do 
	
	subject { page }

	context 'visitor wants to register' do
		before(:each) { visit new_user_registration_path }

		it { should have_link("terms and conditions") }

		context "visitor clicks on T&Cs link" do
			it "routes the user to the legal page" do
				click_on "terms and conditions"
				current_path.should == legal_path
				should have_content("Legal")
			end
		end
	end
end
require 'spec_helper'

describe "Devise#user_sign_up_page" do 
	
	subject { page }

	context 'visitor wants to register' do
		before(:each) { visit new_user_registration_path }

		it { should have_link("Terms of Use") }
		it { should have_link("Privacy Policy") }

		context "visitor clicks on T&Cs link" do
			it "routes the user to the T&C pdf" do
				click_on "Terms of Use"
				current_path.should == "/Terms_of_Use.pdf"
			end
		end
		context "visitor clicks on Privacy Policy link" do
			it "routes the user to the Privacy Policy pdf" do
				click_on "Privacy Policy"
				current_path.should == "/Privacy_Policy.pdf"
			end
		end

	end
end
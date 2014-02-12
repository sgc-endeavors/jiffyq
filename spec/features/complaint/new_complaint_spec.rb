require 'spec_helper'

describe "Complaint#New_page" do 
	before(:each) { FactoryGirl.create(:problem) }

	subject{ page }

	context "visitor wishes to report a problem/complaint" do
		before(:each) { visit new_complaint_path }

		context "visitor fills in a complaint" do
			let(:new_complaint) { FactoryGirl.build(:complaint) }
			before(:each) do
				select new_complaint.problem.name, from: "complaint_problem_id"
				fill_in "complaint_complainer_email", with: new_complaint.complainer_email
				fill_in "complaint_notes", with: new_complaint.notes
				click_on "Submit"
			end

			it "saves the complaint" do
				saved_complaint = Complaint.last
				saved_complaint.complainer_email.should == new_complaint.complainer_email
				saved_complaint.problem.name.should == "This site stinx"
			end

			it "routes the complainer back to the home page" do
				current_path.should == home_path
			end
		end
	end
end

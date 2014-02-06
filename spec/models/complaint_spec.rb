require 'spec_helper'

describe Complaint do
  it "has a valid factory" do
  	FactoryGirl.create(:complaint).should be_valid
  end

  it { should belong_to(:problem) }
  it { should belong_to(:complaint_status) }
end

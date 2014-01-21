require 'spec_helper'

describe Message do
  it "has a valid factory" do
  	FactoryGirl.create(:message).should be_valid
  end

  it { should belong_to(:image) }


  it { should belong_to(:user) }
end

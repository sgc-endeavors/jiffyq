require 'spec_helper'

describe Favorite do
	it "has a valid factory" do
  	FactoryGirl.create(:favorite).should be_valid
  end

  it { should belong_to(:poll) }
  it { should belong_to(:user) }
end

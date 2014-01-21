require 'spec_helper'

describe User do
  it "has a valid factory" do
  	FactoryGirl.create(:user).should be_valid
  end

  it { should have_many(:messages) }
end

require 'spec_helper'

describe Message do
  it "has a valid factory" do
  	FactoryGirl.create(:message).should be_valid
  end

  it { should belong_to(:image) }
  it { should belong_to(:user) }

  #DESTROY RELATED IMAGE - identifies whether the image associated w/ the message should be destroyed.
  it { should respond_to(:destroy_related_image) }

  describe "#destroy_related_image" do
  	before(:each) do
  		@user = FactoryGirl.create(:user)
  		@message = FactoryGirl.create(:message, user_id: @user.id)
  	end
  	
  	it "deletes the related image" do
  		@message.destroy_related_image(@message.image_id)
  		expect {Image.find(@message.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
  	end
  end

 	#COUNT PAGE VIEWS - counts the number of times a page is viewed
 	it { should respond_to(:count_page_views) }

 	describe "#count_page_views" do
 		before(:each) do
 			@message = FactoryGirl.create(:message)
 		end

 		it "should add +1 to the message's page_views total if visitor is not the author" do
 			@message.count_page_views
 			@message.page_views.should == 1
 		end

 		xit "should NOT add +1 to the message's page_views total if visitor IS the author" do
 			current_user = @message.user
 			@message.count_page_views
 			@message.page_views.should == 0
 		end



 	end

end

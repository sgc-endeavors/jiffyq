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
 		  @user = FactoryGirl.create(:user)
      @message = FactoryGirl.create(:message, user_id: @user.id)
 		end

    context "visitor is logged in and IS the author" do
      it "should NOT add +1 to the message's page_views total" do
        @message.count_page_views(0, @message.user)
        @message.page_views.should == 0
      end
    end 		

    context "visitor is logged in and is not the author" do
      before(:each) do
        @a_different_user = FactoryGirl.create(:user)
      end

      context "visitor visits the show page from a link" do
        before(:each) do
          @response = 0
        end
        
        it "should add +1 to the message's page_views total" do
     			@message.count_page_views(@response, @a_different_user)
     			@message.page_views.should == 1
     		end
      end

      context "visitor visits the show page and presses either response button" do
        before(:each) do
          @response = 1
        end
        
        it "should NOT add +1 to the message's page_views total" do
          @message.count_page_views(@response, @a_different_user)
          @message.page_views.should == 0
        end
      end
 




    end



 	end

end

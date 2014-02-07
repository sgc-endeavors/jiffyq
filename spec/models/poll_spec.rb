require 'spec_helper'

describe Poll do
  it "has a valid factory" do
  	FactoryGirl.create(:poll).should be_valid
  end

  it { should belong_to(:image) }
  it { should belong_to(:user) }

  #DESTROY RELATED IMAGE - identifies whether the image associated w/ the poll should be destroyed.
  it { should respond_to(:destroy_related_image) }

  describe "#destroy_related_image" do
  	before(:each) do
  		@user = FactoryGirl.create(:user)
  		@poll = FactoryGirl.create(:poll, user_id: @user.id)
  	end
  	
  	it "deletes the related image" do
  		@poll.destroy_related_image(@poll.image_id)
  		expect {Image.find(@poll.image_id)}.to raise_error(ActiveRecord::RecordNotFound)
  	end
  end

 	#COUNT PAGE VIEWS - counts the number of times a page is viewed
 	it { should respond_to(:count_page_views) }

 	describe "#count_page_views" do
 		before(:each) do
 		  @user = FactoryGirl.create(:user)
      @poll = FactoryGirl.create(:poll, user_id: @user.id)
 		end

    context "visitor is logged in and IS the author" do
      it "should NOT add +1 to the poll's page_views total" do
        @poll.count_page_views(0, @poll.user)
        @poll.page_views.should == 0
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
        
        it "should add +1 to the poll's page_views total" do
     			@poll.count_page_views(@response, @a_different_user)
     			@poll.page_views.should == 1
     		end
      end

      context "visitor visits the show page and presses either response button" do
        before(:each) do
          @response = 1
        end
        
        it "should NOT add +1 to the poll's page_views total" do
          @poll.count_page_views(@response, @a_different_user)
          @poll.page_views.should == 0
        end
      end
 




    end



 	end

end

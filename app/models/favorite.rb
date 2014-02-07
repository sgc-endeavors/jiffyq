class Favorite < ActiveRecord::Base
  attr_accessible :poll_id, :user_id

  belongs_to :user
  belongs_to :poll
end

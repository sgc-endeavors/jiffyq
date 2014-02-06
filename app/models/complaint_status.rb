class ComplaintStatus < ActiveRecord::Base
  attr_accessible :name
  has_many :complaints
end

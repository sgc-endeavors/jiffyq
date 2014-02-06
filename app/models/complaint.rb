class Complaint < ActiveRecord::Base
  attr_accessible :complainer_email, :notes, :status, :targeted_image, :targeted_question, :targeted_user, :type
end

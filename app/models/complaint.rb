class Complaint < ActiveRecord::Base
  attr_accessible :complainer_email, :notes, :targeted_image, :targeted_question, :targeted_user, :problem_id, :complaint_status_id
  belongs_to :problem
  belongs_to :complaint_status
end

class ComplaintsController < ApplicationController

def new
@complaint = Complaint.new
end

def create
	new_complaint = Complaint.new(params[:complaint])
	new_complaint.save!
	redirect_to landing_page_path
end



end

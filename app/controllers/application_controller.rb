class ApplicationController < ActionController::Base
  protect_from_forgery

	rescue_from CanCan::AccessDenied do |exception|
   # flash[:alert] = "Access denied."
    redirect_to landing_page_path
  end


end

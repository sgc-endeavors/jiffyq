class ApplicationController < ActionController::Base
  protect_from_forgery

	rescue_from CanCan::AccessDenied do |exception|
   # flash[:alert] = "Access denied."
    redirect_to home_path
  end


end

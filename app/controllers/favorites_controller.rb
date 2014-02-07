class FavoritesController < ApplicationController
   before_filter :authenticate_user!

  def create
  	poll = Poll.where(identifier: params[:identifier]).first
  	favorite = Favorite.new
  	favorite.user_id = current_user.id
  	favorite.poll_id = poll.id
  	favorite.save!
  	redirect_to polls_path
  end
end

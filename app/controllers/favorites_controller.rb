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

def destroy
	 user = User.find(current_user.id)
    deleted_favorite = Favorite.where(user_id: user.id).where(id: params[:id]).first  
    deleted_favorite.destroy
    redirect_to polls_path and return
end

end

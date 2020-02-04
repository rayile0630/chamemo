class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    memo_room = MemoRoom.find(params[:memo_room_id])
    current_user.like(memo_room)
    flash[:success] = 'いいねしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    memo_room = MemoRoom.find(params[:memo_room_id])
    current_user.unlike(memo_room)
    flash[:success] = 'いいねを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
class ToppagesController < ApplicationController
  def index
    if logged_in?
      @memo_room_post = current_user.memo_room_posts.build
      @memo_room_posts = current_user.memo_room_posts.order(id: :desc).page(params[:page])
      redirect_to controller: 'users', action: 'show', id: current_user.id
    end
  end
end


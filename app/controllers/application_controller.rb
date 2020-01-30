class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @memo_room_posts = user.memo_room_posts.count
    @count_memo_room = user.memo_rooms.count
    @count_favposts = user.favposts.count
  end
end
class MemoRoomCommentsController < ApplicationController
  before_action :require_user_logged_in
  def index
    @memo_room_comments = MemoRoomComment.all
    
  end
    
  def show
    @memo_room = MemoRoom.find(params[:id])
    @memo_room_comments = @memo_room.memo_room_comments
  end
    
  def new
    @memo_room = MemoRoom.find(params[:memo_room_id])
    @memo_room_comment = MemoRoomComment.new
    @memo_room_comments = @memo_room.memo_room_comments
    @memo_room_posts = @memo_room.memo_room_posts
  end
  
  def create
    @memo_room = MemoRoom.find(params[:memo_room_id])
    @memo_room_comment = current_user.memo_room_comments.build(memo_room_comment_params)
    @memo_room_comment.memo_room_id = @memo_room.id
    
    if @memo_room_comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to new_memo_room_memo_room_comment_path(@memo_room)
    else  
      flash.now[:success] = 'コメントの投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @memo_room_comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def memo_room_comment_params
    params.require(:memo_room_comment).permit(:content, :user_id, :memo_room_id)
  end
end

class MemoRoomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @memo_rooms = MemoRoom.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @memo_room = MemoRoom.find(params[:id])
    @memo_room_posts = @memo_room.memo_room_posts
  end
  
  def new
    @memo_room = MemoRoom.new
    @category = Category.new
  end

  def create
    @memo_room = current_user.memo_rooms.build(memo_room_params)

    if @memo_room.save
      flash[:success] = 'メモルームを新規作成しました。'
      redirect_to new_memo_room_memo_room_post_url(@memo_room)
    else
      flash.now[:danger] = 'メモルームを作成出来ませんでした。'
      render :new
    end
  end
  
  def edit
    @memo_room = MemoRoom.find(params[:id])
    @memo_room_post = MemoRoomPost.find(params[:id])
    @memo_room_posts = @memo_room.memo_room_posts
  end
  
  def update
    @memo_room = MemoRoom.find(params[:id])
    
    if @memo_room.update(memo_room_params)
      flash[:success] = 'メモのルームを更新しました。'
      redirect_back(fallback_location: edit_memo_room_path)
    else
      flash.now[:danger] = 'メモルームを更新出来ませんでした。'
      render :edit
    end
  end
  
  def destroy
    @memo_room.destroy
    flash[:success] = 'メモルームを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def search
     @memo_rooms = MemoRoom.search(params[:search])
     if flash[:success] = "#{params[:search]}の検索結果"
  else
     redirect_back(fallback_location: root_path)
     end
  end
  
  private

  def memo_room_params
    params.require(:memo_room).permit(:title, :category_id)
  end
  
  def correct_user
    @memo_room = current_user.memo_rooms.find_by(id: params[:id])
    unless @memo_room
      redirect_to user_path(current_user)
    end
  end
end

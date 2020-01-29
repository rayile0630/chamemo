class MemoRoomPostsController < ApplicationController
  
  def index
    @Memo_room_posts = MemoRoomPost.all.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @memo_room_post = MemoRoomPost.find(params[:id])
    @memo_room_posts = MemoRoomPost.all.order(id: :desc)

    
  end
  
  def new
    @memo_room = MemoRoom.find(params[:memo_room_id])
    @memo_room_post = MemoRoomPost.new
    @memo_room_posts = @memo_room.memo_room_posts
    @memo_room_post.memo_room_id = @memo_room.id
  end
  
  def create
    @memo_room_post = current_user.memo_room_posts.build(memo_room_post_params)
    @memo_room = MemoRoom.find(params[:memo_room_id])
    @memo_room_post.memo_room_id = @memo_room.id
    
    if MemoRoomPost.last.role == 0  #今のままだと不十分。memo_roomとの関連ずけをする
      @memo_room_post.role = 1
    elsif MemoRoomPost.last.role == 1
      @memo_room_post.role = 0
    end
    
    if MemoRoomPost.last.role == nil
      @memo_room_post.role = 1
    end
    if @memo_room_post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_back(fallback_location: new_memo_room_memo_room_post_url(@memo_room))
    else
      @memo_room_posts = current_user.memo_room_posts.order(id: :desc).page(params[:page])
      flash[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
    @memo_room_post = MemoRoomPost.find(params[:id])
  end
  
  def update
    @memo_room_post = MemoRoomPost.find(params[:id])
    if @memo_room_post.update(memo_room_post_params)
      flash[:success] = '投稿 は正常に更新されました'
      redirect_to memo_room_post_path(@memo_room_post)
    else
      flash.now[:danger] = '投稿 は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @memo_room_post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
  end
  
  private
  
  def memo_room_post_params
    params.require(:memo_room_post).permit(:content, :role, :memo_room_id)
  end
end

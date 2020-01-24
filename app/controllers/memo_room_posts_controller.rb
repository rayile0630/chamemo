class MemoRoomPostsController < ApplicationController
  
  def index
    @Memo_room_posts = MemoRoomPost.all.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @memo_room_post = MemoRoomPost.find(params[:id])
  end
  
  def new
    @memo_room_post = MemoRoomPost.new
    @memo_room_posts = MemoRoomPost.all
  end
  
  def create
    @memo_room_post = current_user.memo_room_posts.build(memo_room_post_params)
    if MemoRoomPost.last.role == 0
      @memo_room_post.role = 1
    elsif MemoRoomPost.last.role == 1
      @memo_room_post.role = 0
    else
      @memo_room_post.role = 0
    end
    if @memo_room_post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_back(fallback_location: new_memo_room_post_path)
    else
      @memo_room_posts = current_user.memo_room_posts.order(id: :desc).page(params[:page])
      flash[:danger] = 'メッセージの投稿に失敗しました。'
      redirect_back(fallback_location: new_memo_room_post_path)
    end
  end
  
  def edit
    @memo_room_post = MemoRoomPost.find(params[:id])
  end
  
  def update
    @memo_room_post = Post.find(params[:id])
    if @memo_room_post.update(post_params)
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
    params.require(:memo_room_post).permit(:content, :role)
  end
end

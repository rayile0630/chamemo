class MemoRoomPostsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :new]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @memo_room = MemoRoom.find(params[:memo_room_id])
    @memo_room_posts = MemoRoomPost.all.order(id: :desc).page(params[:page]).per(25)
    @memo_room_post = @memo_room.memo_room_posts
    gon.memo_room_post = @memo_room.memo_room_posts.content #jsに渡すmemo_room_idに紐づいた発言データ
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
    #@memo_roomを使い、MemoRoomPostインスタンスの最後の発言データを取得する
    @lastpost = @memo_room.memo_room_posts.last
    
    if @lastpost == nil  #MemoRoomに紐付いたMemoRoomPostの最後のデータ がnilなら
      @memo_room_post.role = 0 #memo_room_postのrole　を 0　にする。　開始位置 role 0
    elsif @lastpost.role == 0 #MemoRoomに紐付いたMemoRoomPostの最後のデータのroleの値が0なら
      @memo_room_post.role = 1   #memo_room_postのrole の値を 1にする。
    elsif @lastpost.role == 1  ##MemoRoomに紐付いたMemoRoomPostの最後のデータのroleの値が 1なら
      @memo_room_post.role = 0  #memo_room_postのroleの値を 0にする。
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
      redirect_to user_path(current_user)
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
    @memo_room = MemoRoom.find(params[:id])
    @memo_room_post = MemoRoomPost.find(params[:id])
    @memo_room_posts = @memo_room.memo_room_posts
  end
  
  private
  
  def memo_room_post_params
    params.require(:memo_room_post).permit(:content, :role, :memo_room_id)
  end
  
  def correct_user
    @memo_room_post = current_user.memo_rooms.find_by(id: params[:id])
    unless @memo_room_post
      redirect_to user_path(current_user)
    end
  end
end

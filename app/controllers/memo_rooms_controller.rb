class MemoRoomsController < ApplicationController
  def index
    @memo_room = MemoRoom.order(id: :desc).page(params[:page]).per(25)
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
    redirect_to new_memo_room_path
  end
  
  private

  def memo_room_params
    params.require(:memo_room).permit(:title, :category_id)
  end
end

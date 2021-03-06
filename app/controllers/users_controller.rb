class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :frendlists, :likes, :edit]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
    @user = current_user
    @memo_rooms = MemoRoom.all
  end

  def show
    @user = User.find(params[:id])
    @memo_rooms = MemoRoom.all.order(id: :desc)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.picture = "buturirensyu.png"

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィール は正常に更新されました'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'プロフィール は更新されませんでした'
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  def likes
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page]).per(5)
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :picture, :post_a_picture, :post_b_picture)
  end
  
  def correct_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
       redirect_back(fallback_location: user_path(@user))
    end
  end  
  
end

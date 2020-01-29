class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      flash[:success] = 'カテゴリーを新規作成しました。'
      redirect_to new_memo_room_path
    else
      flash.now[:danger] = 'カテゴリーを作成出来ませんでした。'
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    
    if @category.update(category_params)
      flash[:success] = 'カテゴリーを更新しました。'
      redirect_back(fallback_location: edit_category_path)
    else
      flash.now[:danger] = 'カテゴリーを更新出来ませんでした。'
      render :edit
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:title)
  end
  
end

class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :guest_access, only: [:edit]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @tags = Tag.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true) #is_deletedカラムにフラグを立てる(defaultはfalse)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @post_images = PostImage.find(favorites)
    @tags = Tag.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
  end

  def guest_access
    user = User.find(params[:id])
    if user.email == 'guest@example.com'
      flash[:notice] = "本登録をお願いします。"
      redirect_to root_path
    end
  end
end

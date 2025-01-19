class Admin::PostImagesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @post_images = PostImage.all
    @users = User.all
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to admin_post_images_path, notice: '投稿を削除しました。'
  end
end

class Public::PostImagesController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_image_path(@post_image), notice: "投稿が成功しました。"
    else
      render :new
    end
  end

  def index
    @tags = Tag.all

    if params[:latest]
      @post_images = params[:name].present? ? Tag.find(params[:name]).post_images : PostImage.latest
    elsif params[:old]
      @post_images = params[:name].present? ? Tag.find(params[:name]).post_images : PostImage.old
    elsif params[:star_count]
      @post_images = params[:name].present? ? Tag.find(params[:name]).post_images : PostImage.star_count
    else
      @post_images = params[:name].present? ? Tag.find(params[:name]).post_images : PostImage.all
    end
  end

  def show
    @post_image = params[:name].present? ? Tag.find(params[:name]).post_image : PostImage.find(params[:id])
    @post_comment = PostComment.new
    @user = @post_image.user_id
  end

  def edit
    @post_image = params[:name].present? ? Tag.find(params[:name]).post_image : PostImage.find(params[:id])
  end

  def update
    @post_image = params[:name].present? ? Tag.find(params[:name]).post_image : PostImage.find(params[:id])
    if @post_image.update(post_image_params)
    redirect_to post_image_path
    else
      render 'edit'
    end
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to user_path(current_user)
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :body, :postcode, :address, :star, tag_ids:[])
  end

  def is_matching_login_user
    @post_image = params[:name].present? ? Tag.find(params[:name]).post_image : PostImage.find(params[:id])
    unless @post_image.user.id == current_user.id
      redirect_to post_images_path
    end
  end
end

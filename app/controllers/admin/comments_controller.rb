class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @post_comments = PostComment.all
    @users = User.all
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_comments_path, notice: 'コメントを削除しました。'
  end
end
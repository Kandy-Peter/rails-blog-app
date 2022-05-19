class PostsController < ApplicationController
  def index
    @user = User.find_by(id: current_user)
    @posts = Post.where(author_id: current_user)
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end
end

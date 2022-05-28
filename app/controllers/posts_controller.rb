class PostsController < ApplicationController
  def find_user
    @user = User.find(params[:user_id] || current_user.id)
  end

  def index
    @posts = find_user.posts.includes(:comments)
  end

  def show
    @post = find_user.posts.includes(comments: [:user]).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash.now[:error] = 'Post not saved, try again'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.destroy
      @post.update_post_counter(@post.user_id)
      redirect_to user_posts_path
      flash[:success] = 'Post deleted successfully'
    else
      flash.now[:error] = 'Post not deleted, try again'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

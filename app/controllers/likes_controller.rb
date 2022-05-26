class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user_id: current_user.id, post_id: @post.id)

    if @like.save
      flash[:notice] = 'You liked this post'
      redirect_to user_posts_path(current_user, @post)
    else
      flash.now[:alert] = 'Error! Try again.'
      render :new, status: :unprocessable_entity
    end
  end
end

class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:id])
    @like = @post.likes.new(author_id: current_user.id, post_id: @post.id)

    if @like.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}"
    else
      render :new, status: :unprocessable_entity
    end
  end
end
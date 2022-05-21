class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = 'You comment was added to the post'
      redirect_to post_path(@comment.post)
    else
      flash.now[:error] = 'AN error occured, please try again'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

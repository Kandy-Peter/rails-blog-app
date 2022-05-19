class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comment_counter

  def update_comment_counter
    count = Comment.where(post_id: id).count
    post = Post.find_by_id(id: post_id)
    post.update(comments_counter: count)
  end
end

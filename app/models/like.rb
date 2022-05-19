class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_like_counter
    count = Comment.where(post_id: id).count
    post = Post.find_by_id(id: post_id)
    post.update(likes_counter: count)
end

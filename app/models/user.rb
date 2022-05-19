class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def recent_posts
    Post.order(created_at: :desc).where(author: id).first(3)
  end
end

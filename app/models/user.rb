class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  validates :name, :bio, :photo, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    Post.order(created_at: :desc).where(author: id).first(3)
  end
end

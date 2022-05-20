class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def most_recent_comments
    Comment.where(post_id: id).order(created_at: :desc).first(5)
  end
end

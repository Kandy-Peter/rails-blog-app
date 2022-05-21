require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Kandy', photo: 'https://microverse_student.com/img1', bio: 'software Developer form Congo') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than one' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'PostsCounter must be greater than or equal to zero' do
    subject.posts_counter = 2
    expect(subject).to be_valid
  end

  it 'should return the last comments by post' do
    user = User.create(name: 'Bill', bio: 'Teacher from Texas', posts_counter: 0)
    Post.create(author: user, title: 'post', text: 'Post written by mysefl', likes_counter: 1, comments_counter: 4)
    Post.create(author: user, title: 'post1', text: 'Post written by mysefl 1', likes_counter: 4, comments_counter: 9)
    Post.create(author: user, title: 'post2', text: 'Post written by mysefl 2', likes_counter: 1, comments_counter: 2)
    expect(user.recent_posts.length).to eq(3)
  end
end

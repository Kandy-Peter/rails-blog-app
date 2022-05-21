require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'Kandy', photo: 'https://microverse_student.com/img1', bio: 'software Developer form Congo')
    @post = Post.new(author: @user, title: 'post test', text: 'content for checking tests', comments_counter: 0, likes_counter: 0)
  end

  before { @post.save }

  it 'title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title content max 250 characters' do
    @post.title = "title"
    expect(@post).to be_valid
  end

  it 'test if likes counter is greater than or equal to 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end

  it 'test if likes counter is integer' do
    @post.likes_counter = 3
    expect(@post).to be_valid
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'test the post path' do
    before(:each) do
      @user = User.create(name: 'John', bio: 'I am a software developer', posts_counter: 0,
                          email: 'kandy@mail.com', password: 'kandy123')
      @post = Post.create(user: @user, title: 'kandy', text: 'kandying', likes_counter: 7,
                          comments_counter: 5)
    end

    before { @post.save }

    it 'check if the max is 250 characters' do
      @post.title = 'How to become a good developer'
      expect(@post).to be_valid
    end

    it 'check if likes are integer' do
      @post.likes_counter = 1
      expect(@post).to be_valid
    end

    it 'check if likes counter is grater or equal to zero' do
      @post.likes_counter = -3
      expect(@post).to_not be_valid
    end

    it 'check if commnet counter is greater than or equal to zero.' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end

    it 'check if commnet is an integer' do
      @post.comments_counter = 3
      expect(@post).to be_valid
    end
  end
end

RSpec.feature 'for the post_show_pag', type: :feature do
  before(:each) do
    User.destroy_all
    @user = User.create(name: 'kandy_peter', photo: 'kandy_peter.png', bio: 'I am software dveloper',
                        email: 'kandy_peter@mail.com', password: 'password', role: 'admin', posts_counter: 0)
    Post.create(title: 'Title', text: 'My first post', user_id: @user.id, likes_counter: 0, comments_counter: 0)
    @comment = Comment.create(text: 'My first comment', user: User.first, post: Post.first)
    @comment = Comment.create(text: 'My second comment', user: User.first, post: Post.first)
    @like = Like.create(user_id: User.first.id, post_id: Post.first.id)

    visit new_user_session_path
    fill_in 'Email', with: 'kandy_peter@mail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit "/users/#{User.first.id}/posts"
  end

  describe 'Specs for view posts#show' do
    it 'show more content on pagination' do
      expect(page).to have_content('1')
      expect(page).to have_content('2')
      expect(page).to have_content('3')
    end

    it 'show the post title' do
      expect(page).to have_content 'Title'
    end

    it 'show post usernam' do
      expect(page).to have_content 'kandy_peter'
    end

    it 'show the post text.' do
      expect(page).to have_content 'My first post'
    end

    it 'show the post likes counter.' do
      expect(page).to have_content 'Likes 1'
    end

    it 'show the post comments counter.' do
      expect(page).to have_content 'Comments 2'
    end

    it 'show the post comments.' do
      expect(page).to have_content 'My first comment'
      expect(page).to have_content 'My second comment'
    end
  end
end
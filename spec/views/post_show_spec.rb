require 'rails_helper'

RSpec.describe 'post_show_route', type: :feature do
  describe 'Post' do
    before(:each) do
      @first_user = User.create(name: 'kandy', photo: 'link', bio: 'Programmer from Malawi', posts_counter: 0,
                                email: 'kandy@mail.com', password: 'password', password_confirmation: 'password')

      visit new_user_session_path
      fill_in 'Email', with: 'kandy@mail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'

      @post = Post.create(title: 'First Post', text: 'This is the first post', comments_counter: 3, likes_counter: 0,
                          user: @first_user)
      @posta = Post.create(title: 'Second Post', text: 'This is the second post', comments_counter: 0,
                           likes_counter: 0, user: first_user)
      @postb = Post.create(title: 'Third Post', text: 'This is the third post', comments_counter: 0, likes_counter: 0,
                           user: @first_user)

      @first_comment = Comment.create(text: 'My first comment', user: User.first, post: Post.first)
      @second_comment = Comment.create(text: 'My second comment', user: User.first, post: Post.first)

      @likeable = Like.create(user: User.last, post: Post.first)
      @likee = Like.create(user: User.first, post: Post.first)

      visit user_post_path(@first_user.id, @post.id)
    end

    it 'displays post title' do
      post = Post.first
      expect(post.title).to eql('First Post')
    end

    it 'display user\'s username' do
      post = Post.first
      expect(post.user.name).to eql('kandy')
    end

    it 'displays number of comments' do
      post = Post.first
      expect(post.comments_counter).to eql(2)
    end

    it 'displays number of likes' do
      post = Post.first
      expect(post.likes_counter).to eql(2)
    end

    it 'displays contents of post' do
      expect(page).to have_content('This is the first post')
    end

    it 'displys the name of each commentor' do
      @post.comments.each do |comment|
        expect(comment.user.name).to eq('kandy')
        expect(comment.user.name).to eq('kandy')
      end
    end

    it 'displays content of each comment' do
      expect(page).to have_content('My first comment')
      expect(page).to have_content('My second comment')
      expect(page).to have_content('My third comment')
    end
  end
end

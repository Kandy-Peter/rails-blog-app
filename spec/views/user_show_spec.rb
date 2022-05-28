require 'rails_helper'
RSpec.describe 'user_show_path', type: :feature do
  describe 'User show page' do
    before(:each) do
      @first_user = User.create(name: 'kandy', photo: 'kandy_peter.png', bio: 'bio', posts_counter: 0,
                                email: 'kandy@mail', password: 'password', password_confirmation: 'password')
      visit('users/sign_in')
      fill_in 'Email', with: 'kandy@mail'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      @first_post = Post.create(user: @first_user, title: 'firs post', text: 'This is my first post')
      @second_post = Post.create(user: @first_user, title: 'second post', text: 'This is my second post')
      @third_post = Post.create(user: @first_user, title: 'third post', text: 'This is my third post')

      visit user_path(@first_user.id)
    end
    it 'Check for user profile picture' do
      all('img').each do |i|
        expect(i[:src]).to eq('kandy_peter.png')
      end
    end
    it 'check user name' do
      expect(page).to have_content('kandy')
    end
    it 'check the number of posts by user' do
      expect(page).to have_content(3)
    end
    it 'check the user bio' do
      expect(page).to have_content('bio')
    end
    scenario "Check the user's the user's posts" do
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to have_content('This is my third post')
    end
    it 'check the button to see all posts by user' do
      expect(page).to have_button('See all posts')
    end
    it 'onclik, check if user is redirect to the posts page' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@first_user)
    end
  end
end
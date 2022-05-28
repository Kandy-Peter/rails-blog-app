require 'rails_helper'
RSpec.describe 'user_index_path', type: :feature do
  describe 'User_index_view' do
    before(:each) do
      @first_user = User.create(name: 'Jond_Doe', photo: 'url', bio: 'Developer from Ghana',
                                posts_counter: 0, email: 'jond_doe@mail.com',
                                password: 'password', password_confirmation: 'password')
      @second_user = User.create(name: 'John', photo: 'url', bio: 'Designer from Ghana',
                                 posts_counter: 2, email: 'john@mail.com',
                                 password: 'password', password_confirmation: 'password')
      @third_user = User.create(name: 'Marcus', photo: 'url', bio: 'Developer from Ghana',
                                posts_counter: 4, email: 'marcus@mail.com',
                                password: 'password', password_confirmation: 'password')
      visit('users/sign_in')
      fill_in 'Email', with: 'jond_doe@mail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      click_link 'All Users'
    end
    it 'displays all users' do
      expect(page).to have_content('Jond_Doe')
      expect(page).to have_content('John')
      expect(page).to have_content('Marcus')
    end
    it 'display user profile picture' do
      all('img').each do |i|
        expect(i[:src]).to eq('url')
      end
    end
    it "display user's number of posts" do
      expect(page).to have_content(0)
      expect(page).to have_content(2)
      expect(page).to have_content(4)
    end
    it "redirects to user's show page" do
      click_link 'Jond_Doe'
      expect(page).to have_content('Jond_Doe')
    end
  end
end

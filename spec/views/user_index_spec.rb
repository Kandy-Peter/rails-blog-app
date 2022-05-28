require 'rails_helper'

RSpec.feature 'Test user_index_path', type: :feature do
  before(:each) do
    @first_user = User.create(name: 'kandy', photo: 'profile_photo.png',
                              bio: 'Teacher from Mexico.', email: 'kandy@gmail.com',
                              password: '123456', posts_counter: 0, role: 'admin')

    @second_user = User.create(name: 'James', photo: 'profile_photo.png',
                              bio: 'Teacher from Mexico.', email: 'james@gmail.com',
                              password: '123456', posts_counter: 0, role: 'admin')

    Post.create(title: 'I am sofwatre developer', text: 'Here is my first article',
                user_id: @first_user.id, created_at: Time.now, updated_at: Time.now)

    visit user_session_path

    within 'form' do
      fill_in 'Email', with: @first_user.email
      fill_in 'Password', with: @first_user.password
    end

    click_button 'Log in'
  end

  background { visit root_path }
  scenario 'Check all users name on render' do
    expect(page).to have_content('kandy')
    expect(page).to have_content('James')
  end

  scenario "Check the first user's picture" do
    expect(page.first('img')['src']).to have_content 'profile_photo.png'
  end

  scenario "Check user's number of posts" do
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 0')
  end

  scenario "On click on the user name, it redirect to the show path" do
    click_link 'kandy', match: :first
    expect(current_path).to eq user_path(User.first.id)
  end
end

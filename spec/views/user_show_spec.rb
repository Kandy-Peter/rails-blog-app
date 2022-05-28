require 'rails_helper'

RSpec.feature 'user_show_path', type: :feature do
  before(:each) do
    User.destroy_all
    @first = User.create(name: 'Kandy', photo: 'https://kandypeter.com/1',
                         bio: 'Software developer from Congo', email: 'Kandy@gmail.com',
                         password: '123456', role: 'admin', posts_counter: 0)

    Post.create(title: '5 ways to become a good dev', text: 'my first blog in this topic', author_id: @first.id,
                likes_counter: 0, comments_counter: 0)
    Post.create(title: 'Best JS hacks', text: 'my first blog in this topic', author_id: @first.id, likes_counter: 0,
                comments_counter: 0)
    Post.create(title: 'My coding life', text: 'my first blog in this topic', author_id: @first.id, likes_counter: 0,
                comments_counter: 0)

    visit user_session_path
    within 'form' do
      fill_in 'Email', with: @first.email
      fill_in 'Password', with: @first.password
    end
    click_button 'Log in'
  end

  background { visit user_path(User.first.id) }

  scenario 'check the show page with expected username' do
    expect(page).to have_content('Kandy')
  end

  scenario 'check the show page with expected picture' do
    expect(page.first('img')['src']).to have_content 'https://kandypeter.com/1'
  end

  scenario 'check the show page with expected number of posts' do
    expect(page).to have_content('number of posts: 0')
  end

  scenario 'check the show page with expected bio' do
    expect(page).to have_content('Software developer form Congo')
  end

  scenario 'check the show page with expected posts' do
    expect(page).to have_content('5 ways to become a good dev')
    expect(page).to have_content('Best JS hacks')
    expect(page).to have_content('My coding life')
  end

  scenario "Button to see all user's posts" do
    click_link('All posts')
    expect(current_path).to eq user_posts_path(User.first.id)
  end
end

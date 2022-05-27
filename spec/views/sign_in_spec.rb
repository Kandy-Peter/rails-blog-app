require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Login_view', type: :feature do
  background { visit new_user_session_path }
  scenario 'displays form fields' do
    sleep(10)
    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[password]')
    expect(page).to have_button('Log in')
  end

  context 'Submitting form' do
    scenario 'If the form submitted is empty' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password.'
    end

    scenario 'Submitting form with the incorrect email and password' do
      visit new_user_session_path
      fill_in 'Email', with: 'kandypeter03@gmail.com'
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'Submitting form with the correct email and password' do
      @user = User.create(name: 'kandy Peter', email: 'kandypeter03@gmail.com',
                          password: '123456', bio: 'Iam a software developer', photo: 'https://kandy.com', posts_counter: 0)
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end

# rubocop:enable Metrics/BlockLength

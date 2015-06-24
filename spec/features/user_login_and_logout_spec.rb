require 'rails_helper'

feature 'User logs in and logs out' do
  scenario 'with correct details', js: true do
    create(:user, email: 'someone@example.tld', password: 'somepassword')

    visit '/'

    click_link 'Log in'
    expect(page).to have_css('h2', text: 'Log in')
    expect(current_path).to eq(new_user_session_path)

    login 'someone@example.tld', 'somepassword'

    expect(page).to have_css('h1', text: 'Welcome to RSpec Rails Examples')
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Hello, someone@example.tld'

    click_button 'Log out'

    expect(current_path).to eq '/'
    expect(page).to have_content 'Signed out successfully'
    expect(page).not_to have_content 'someone@example.tld'
  end

  private

    def login(email, password)
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end
end
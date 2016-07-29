require_relative 'web_helpers.rb'

feature 'user signs up' do
  scenario 'I can sign up a new user'do
  expect { sign_up }.to change(User, :count).by(1)
  expect(page).to have_content('Welcome, Giancarlo Fabrizi')
  expect(User.first.email).to eq('gfabrizi@gmail.com')
  end

  scenario 'it makes sure that the passwords match' do
    expect{ sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end

  def sign_up(first_name: 'Giancarlo', surname: 'Fabrizi', email: 'gfabrizi@gmail.com', password: 'password', password_confirmation: 'password')
    visit '/user/new'
    fill_in 'first_name', with: first_name
    fill_in 'surname', with: surname
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Add user'
  end

  scenario 'mismatched password keeps you on the same page' do
      expect{ sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
      expect(current_path).to eq '/user'
      expect(page).to have_content 'Please refer to the following errors below:'
    end

  scenario 'Cannot sign up without entering an email' do
    expect{ sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eq('/user')
    expect(page).to have_content('Email must not be blank')
  end

  scenario 'Cannot sign up with an invalid email address' do
    expect{ sign_up(email: 'invalemail') }.not_to change(User, :count)
    expect(current_path).to eq('/user')
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'Cannot sign up with an already registered email' do
    sign_up
    expect{ sign_up }.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end

  scenario 'user can sign in' do
    visit '/user/sign_in'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
    expect(page).to have_content('Welcome email')
  end
end

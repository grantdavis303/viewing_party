require 'rails_helper'

RSpec.describe 'Login Page', type: :feature do
  it "happy path for logging in" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "test", password_confirmation: "test")

    visit root_path
  
    click_button "Login Existing User"

    expect(current_path).to eq("/login")
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)

    fill_in :email, with: "tommy@email.com"
    fill_in :password, with: "test"
    click_button("Log In")

    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_content("Tommy's Dashboard")
  end

  it "sad path for logging in" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "test", password_confirmation: "test")

    visit root_path

    click_button "Login Existing User"

    expect(current_path).to eq("/login")
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)

    fill_in :email, with: "tommy@email.com"
    fill_in :password, with: "test123"
    click_button("Log In")

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
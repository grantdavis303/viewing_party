require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do

  # User Story 7
  it "user show page has section for parties they are hosting" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "test", password_confirmation: "test")
    @guest_1 = User.create!(name: 'Richard', email: 'richard@email.com', password: "test", password_confirmation: "test")
    @guest_2 = User.create!(name: 'Michael', email: 'michael@email.com', password: "test", password_confirmation: "test")
    new_viewing_party = ViewingParty.create!(duration: rand(0..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"))
    UserParty.create!(viewing_party: new_viewing_party, user: @user, host: true)
    UserParty.create!(viewing_party: new_viewing_party, user: @guest_1, host: false)
    UserParty.create!(viewing_party: new_viewing_party, user: @guest_2, host: false) 
    new_viewing_party2 = ViewingParty.create!(duration: rand(0..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"))
    UserParty.create!(viewing_party: new_viewing_party2, user: @guest_1, host: true)
    UserParty.create!(viewing_party: new_viewing_party2, user: @user, host: false)

    visit "/users/#{@user.id}"

    # I should see the viewing parties that the user has been invited to with the following details:
    within ".parties_hosting" do
      # - Movie Image
      # - Movie Title, which links to the movie show page
      expect(page).to have_content("Party Time: #{new_viewing_party.date} at #{new_viewing_party.start_time}")
      expect(page).to have_content("Host: Tommy")
      expect(page).to have_content("Tommy")
      expect(page).to have_content("Richard") 
      expect(page).to have_content("Michael")      
    end

    # I should also see the viewing parties that the user has created (hosting) with the following details:
    within ".parties_not_hosting" do
      # - Movie Image
      # - Movie Title, which links to the movie show page
      expect(page).to have_content("Party Time: #{new_viewing_party2.date} at #{new_viewing_party2.start_time}")
      expect(page).to have_content("Host: Richard")
      expect(page).to have_content("Tommy")
      expect(page).to have_content("Richard") 
    end
  end
end
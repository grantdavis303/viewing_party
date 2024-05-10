require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
  
  # User Story 4
  it "new viewing party page has all fields" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    json_response = File.read('spec/fixtures/movie_dune.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/movies/693134/viewing_party/new"

    expect(page).to have_content("Create a Viewing Party for Dune: Part Two")

    within ".new_vp_form" do
      within ".party_details" do
        expect(page).to have_content("Movie Name: Dune: Part Two")  # Movie Title
        expect(page).to have_field (:party_duration)                # Party Duration
        expect(find_field(:party_duration).value).to eq ("167")     # Party Duration Default Value of 167
        expect(page).to have_field (:party_date)                    # Party Date
        expect(page).to have_field (:game_game_time_4i)             # Party Time (Hours)
        expect(page).to have_field (:game_game_time_5i)             # Party Time (Minutes)
      end
      within ".guest_details" do
        expect(page).to have_field (:guest_1)
        expect(page).to have_field (:guest_2)
        expect(page).to have_field (:guest_3)        
      end
      expect(page).to have_button ("Create Party")   
    end
  end

  it "new viewing party can be created" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @guest_1 = User.create!(name: 'Michael', email: 'michael@email.com')
    @guest_2 = User.create!(name: 'Bob', email: 'bob@email.com')

    json_response = File.read('spec/fixtures/movie_dune.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/movies/693134/viewing_party/new"

    within ".guest_details" do
      fill_in (:guest_1), with: "#{@guest_1.id}"
      fill_in (:guest_2), with: "#{@guest_2.id}"
    end

    click_button "Create Party"

    expect(current_path).to eq("/users/#{@user.id}")

    within ".parties_hosting" do
      expect(page).to have_content("Movie Title: 693134")
      expect(page).to have_content("Host: Tommy")
      expect(page).to have_content("Tommy")
      expect(page).to have_content("Michael")
      expect(page).to have_content("Bob")
    end

  end

  # Need Validation Test for Duration Less than Movie
end
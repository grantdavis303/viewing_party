require 'rails_helper'

RSpec.describe 'Viewing Party Show Page', type: :feature do

  # User Story 5
  it "lists all icons for movies to rent and buy" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    json_response = File.read('spec/fixtures/movie_dune_providers.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134/watch/providers?api_key=0f7ff543b9146c27bb69c85b227e5f63").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/movies/693134/viewing_party/12"

    expect(page).to have_content("All Buy/Rent data is provided by JustWatch")

    within ".movies_to_buy" do
      expect(page).to have_content("Apple TV")
      expect(page.find('#logo_2')['src']).to have_content("/9ghgSC0MA082EL6HLCW3GalykFD.jpg")
      expect(page).to have_content("Amazon Video")
      expect(page.find('#logo_10')['src']).to have_content("/seGSXajazLMCKGB5hnRCidtjay1.jpg")
      expect(page).to have_content("Google Play Movies")
      expect(page.find('#logo_3')['src']).to have_content("/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg")
    end

    within ".movies_to_rent" do
      expect(page).to have_content("Apple TV")
      expect(page.find('#logo_2')['src']).to have_content("/9ghgSC0MA082EL6HLCW3GalykFD.jpg")
      expect(page).to have_content("Amazon Video")
      expect(page.find('#logo_10')['src']).to have_content("/seGSXajazLMCKGB5hnRCidtjay1.jpg")
      expect(page).to have_content("Spectrum On Demand")
      expect(page.find('#logo_486')['src']).to have_content("/aAb9CUHjFe9Y3O57qnrJH0KOF1B.jpg")
    end
  end
end
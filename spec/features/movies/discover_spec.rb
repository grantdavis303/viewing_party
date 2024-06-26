require 'rails_helper'

RSpec.describe 'User Discover Movies Page', type: :feature do

  # User Story 1
  it "has search button and movie discover button" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "test", password_confirmation: "test")

    visit "/users/#{@user.id}/discover"

    within ".find_movies" do
      expect(page).to have_link("Discover Top Rated Movies", href: "/users/#{@user.id}/movies")
      expect(page).to have_field(:search_by_movie_title)
      expect(page).to have_button("Search")
    end
  end

  # User Story 2 - Path 1 (Discover Top Rated Movies)
  it "discover top rated movies button leads to the movies page" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "test", password_confirmation: "test")
    json_response = File.read('spec/fixtures/movies_list.json')
    stub_request(:get, "https://api.themoviedb.org/3/trending/movie/week?api_key=0f7ff543b9146c27bb69c85b227e5f63").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/discover"
    click_on ("Discover Top Rated Movies")

    expect(current_path).to eq("/users/#{@user.id}/movies")

    within ".movies_list" do
      expect(page).to have_link("Dune: Part Two", href: "/users/#{@user.id}/movies/693134")
      expect(page).to have_content("Vote Average: 8.2")
      expect(page).to have_link("Godzilla Minus One", href: "/users/#{@user.id}/movies/940721")
      expect(page).to have_content("Vote Average: 7.8")
      expect(page).to have_link("Ghostbusters: Frozen Empire", href: "/users/#{@user.id}/movies/967847")
      expect(page).to have_content("Vote Average: 6.49")
    end
    
    expect(page).to have_link("Return to Discover Page", href: "/users/#{@user.id}/discover")
  end

  # User Story 2 - Path 2 (Search)
  it "search button leads to the movies page" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "test", password_confirmation: "test")
    json_response = File.read('spec/fixtures/movies_list_tron.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=0f7ff543b9146c27bb69c85b227e5f63&query=Tron").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/discover"
    fill_in :search_by_movie_title, with: "Tron"
    click_on ("Search")

    expect(current_path).to eq("/users/#{@user.id}/movies")
  
    within ".movies_list" do
      expect(page).to have_link("Tron", href: "/users/#{@user.id}/movies/97")
      expect(page).to have_content("Vote Average: 6.7")
      expect(page).to have_link("Throne", href: "/users/#{@user.id}/movies/1231003")
      expect(page).to have_content("Vote Average: 0.0")
      expect(page).to have_link("TRON: Legacy", href: "/users/#{@user.id}/movies/20526")
      expect(page).to have_content("Vote Average: 6.47")
    end
    
    expect(page).to have_link("Return to Discover Page", href: "/users/#{@user.id}/discover")
  end
end
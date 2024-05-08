require 'rails_helper'

RSpec.describe 'User Discover Movies Page', type: :feature do

  # User Story 1
  it "has search button and movie discover button" do
    # Setup
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')

    # As a user, when I visit the '/users/:id/discover' path (where :id is the id of a valid user),
    visit "/users/#{@user.id}/discover"

    # I should see
    within ".find_movies" do
      # Button to Discover Top Rated Movies
      expect(page).to have_link("Discover Top Rated Movies", href: "/users/#{@user.id}/movies")
      # Text field to enter keyword(s) to search by movie title
      expect(page).to have_field(:search_by_movie_title)
      # Button to Search by Movie Title
      expect(page).to have_button("Search")
    end

    # Clicking the form Search button brings the user to the movies page
    click_on ("Search")
    expect(current_path).to eq("/users/#{@user.id}/movies")
  end

end
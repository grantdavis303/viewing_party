require 'rails_helper'

RSpec.describe 'Movies Show Page', type: :feature do

  # User Story 3
  it "discover top rated movies button leads to the movies page" do
    # Setup
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    json_response = File.read('spec/fixtures/movie_dune.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews").to_return(status: 200, body: json_response)

    # As a user, when I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
    visit "/users/#{@user.id}/movies/693134"

    # I should see
    within ".links" do
      expect(page).to have_link("Create a Viewing Party")
      expect(page).to have_link("Return to Discover")
    end
    
    # I should also see the following information about the movie:
    within ".movie_details" do
      expect(page).to have_content("Dune: Part Two")
      expect(page).to have_content("8.215")
      expect(page).to have_content("Runtime: 2 Hours and 47 Minutes") 
    end

    # Movie Summary
    within ".movie_description" do
      expect(page).to have_content("Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.")
    end

    # Movie Genre(s)
    within ".movie_genre" do
      expect(page).to have_content("Science Fiction")
      expect(page).to have_content("Adventure")
    end

    # Movie Cast
    within ".movie_cast" do
      expect(page).to have_content("Timothée Chalamet")
      expect(page).to have_content("Zendaya")
      expect(page).to have_content("Rebecca Ferguson")
    end

    # Movie Reviews
    within ".movie_reviews" do
      expect(page).to have_content("Total Reviews: 9")
      expect(page).to have_content("Review by: Manuel São Bento")
        # Add Review - weird string thing
      expect(page).to have_content("Review by: r96sk")
        # Add Review - weird string thing
    end
  end
end
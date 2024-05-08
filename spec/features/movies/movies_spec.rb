require 'rails_helper'

RSpec.describe 'Movies Show Page', type: :feature do

  # User Story 3
  it "discover top rated movies button leads to the movies page" do
    # Setup
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    json_response = File.read('spec/fixtures/movie_dune.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134?api_key=0f7ff543b9146c27bb69c85b227e5f63")
      .to_return(status: 200, body: json_response)

    # As a user, when I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
    visit "/users/#{@user.id}/movies/693134"

    save_and_open_page

    # # I should see
    # within ".links" do
    #   # a button to Create a Viewing Party
    #   expect(page).to_have_content("")
    #   # a button to return to the Discover Page
    # end
    
    # # I should also see the following information about the movie:
    
    # # - Movie Title
    # # - Vote Average of the movie
    # # - Runtime in hours & minutes
    # # - Genre(s) associated to movie
    # # - Summary description
    # # - List the first 10 cast members (characters & actress/actors)
    # # - Count of total reviews
    # # - Each review's author and information
    end
end
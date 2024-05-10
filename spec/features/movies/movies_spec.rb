require 'rails_helper'

RSpec.describe 'Movies Show Page', type: :feature do

  # User Story 3
  it "discover top rated movies button leads to the movies page" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    json_response = File.read('spec/fixtures/movie_dune.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/movies/693134"

    within ".links" do
      expect(page).to have_link("Create a Viewing Party", href: "/users/#{@user.id}/movies/693134/viewing_party/new")
      expect(page).to have_link("Return to Discover")
    end
    
    within ".movie_details" do
      expect(page).to have_content("Dune: Part Two")
      expect(page).to have_content("8.215")
      expect(page).to have_content("Runtime: 2 Hours and 47 Minutes") 
    end

    within ".movie_description" do
      expect(page).to have_content("Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.")
    end

    within ".movie_genre" do
      expect(page).to have_content("Science Fiction")
      expect(page).to have_content("Adventure")
    end

    within ".movie_cast" do
      expect(page).to have_content("Timothée Chalamet")
      expect(page).to have_content("Zendaya")
      expect(page).to have_content("Rebecca Ferguson")
    end

    within ".movie_reviews" do
      expect(page).to have_content("Total Reviews: 9")
      expect(page).to have_content("Review by: Manuel São Bento")
      # Add Review - weird string formatting
      # expect(page).to have_content ("FULL SPOILER-FREE REVIEW @ https://talkingfilms.net/dune-part-two-review-the-new-generational-epitome-of-sci-fi-epics/\r\n\r\n\"Dune: Part Two surpasses even the highest expectations, establishing itself as an unquestionable technical masterpiece of blockbuster filmmaking.\r\n\r\nWith a narrative that deepens the complex web of political relationships, power, faith, love, and destiny, it not only provides a breathtaking audiovisual spectacle, thanks to the genius of Denis Villeneuve, Greig Fraser, and Hans Zimmer, but it also offers a profound meditation on universal human themes through thematically rich world-building and thoroughly developed characters. The superb performances of the entire cast, led by a career-best Timothée Chalamet and a mesmerizing Zendaya, further elevate this incredibly immersive cinematic experience.\r\n\r\nIt warrants comparisons with the greatest sequels in history, easily becoming the new generational epitome of sci-fi epics.\"\r\n\r\nRating: A+")
      expect(page).to have_content("Review by: r96sk")
      # Add Review - weird string formatting
      # expect(page).to have_content ("As anticipated, a thrilling watch!\r\n\r\nI enjoyed <em>'Dune'</em>, though remember thinking it was obviously a complete set-up to a sequel and that this would only improve upon its predecessor - and that's very much the case. <em>'Dune: Part Two'</em> is excellent! My interest did wane slightly at roughly the middle part, as was similarly the case with the first film in truth, but that was a feeling that only lasted for a relativiely short time.\r\n\r\nAll in all, it's fantastic. The acting is top notch, the visuals are breathtaking <em>(those sandworms tho)</em> and the score is outstandingly hefty - you can always rely on the great Hans Zimmer! Timothée Chalamet stars yet again, as do the likes of Rebecca Ferguson, Zendaya, Dave Bautista & Co. The person I actually enjoyed most on screen was Javier Bardem, who is truly brilliant throughout. \r\n\r\nBring on <em>'Dune Messiah'</em>! On that note, happy to read that director Denis Villeneuve has noted that he won't be rushing that one out - and rightly so!")
    end
  end

  # User Story 6
  it "Has link for similar movies" do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    json_response = File.read('spec/fixtures/movie_dune.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews").to_return(status: 200, body: json_response)

    visit "/users/#{@user.id}/movies/693134"

    within ".links" do
      expect(page).to have_link("Get Similar Movies")
    end

    json_response = File.read('spec/fixtures/movie_dune_similar.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/693134/similar?api_key=0f7ff543b9146c27bb69c85b227e5f63").to_return(status: 200, body: json_response)

    click_link("Get Similar Movies")

    expect(current_path).to eq("/users/#{@user.id}/movies/693134/similar")

    within "#similar_movie_15074" do
      expect(page).to have_content("Extreme Ops")
      expect(page).to have_content("Overview: While filming an advertisement, some extreme sports enthusiasts unwittingly stop a group of terrorists.")
      expect(page).to have_content("Release Date: 2002-11-27")
      expect(page.find('#img_15074')['src']).to have_content("/984tq1bRL2uzR0wHrNzZVYTR0Al.jpg")
      expect(page).to have_content("Vote Average: 4.8")
    end
  end
end
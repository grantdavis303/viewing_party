class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:id])
    @all_users = User.all

    movie_id = params["movie_id"]
    request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews")
    parsed_json = JSON.parse(request.body)
    @requested_movie = parsed_json
  end

  def create
    @user = User.find(params[:id])

    new_viewing_party = ViewingParty.create!(
      duration: params[:party_duration],
      date: params[:party_date],
      start_time: "#{params["game"]["game_time(4i)"].to_i}:#{params["game"]["game_time(5i)"].to_i}",
    )

    # new_user_party = UserParty.create!(
    #   viewing_party: new_viewing_party.id, 
    #   user: @user.id, 
    #   host: true
    # )

    redirect_to "/"
  end

  def show
    # binding.pry
    # @party = ViewingParty.find("")
  end
end
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

    redirect_to "/users/#{@user.id}"
  end

  def show
    movie_id = params["movie_id"]
    request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}/watch/providers?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    parsed_json = JSON.parse(request.body)
    @where_to_rent = parsed_json["results"]["US"]["rent"]
    @where_to_buy = parsed_json["results"]["US"]["buy"]
  end
end
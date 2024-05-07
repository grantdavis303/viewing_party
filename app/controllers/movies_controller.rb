class MoviesController < ApplicationController
  def discover
    @user = User.find(params[:id])
  end

  def movies
    @user = User.find(params[:id])
    if params.include? (:search_by_movie_title)
      request = Faraday.get("https://api.themoviedb.org/3/search/movie?query=#{params[:search_by_movie_title]}&api_key=0f7ff543b9146c27bb69c85b227e5f63")
    else
      request = Faraday.get("https://api.themoviedb.org/3/trending/movie/week?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    end
    parsed_json = JSON.parse(request.body)
    @requested_movies = parsed_json["results"]
  end

  def show
    # movie_id = params["movie_id"]
    #@movie = Faraday.get("https://api.themoviedb.org/3/find/#{movie_id}?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    @movie = @requested_movies.find(params["movie_id"])
  end
end

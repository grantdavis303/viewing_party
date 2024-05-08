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
    @user = User.find(params[:id])
    #https://api.themoviedb.org/3/movie/550?api_key=0f7ff543b9146c27bb69c85b227e5f63&language=en-US&append_to_response=credits

    # Movie Information
    movie_id = params["movie_id"]
    request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    @requested_movie = JSON.parse(request.body)

    # Movie Cast
    cast_request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    @requested_movie_cast = JSON.parse(cast_request.body)["cast"][0...10]

    # Movie Reviews
    review_request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}/reviews?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    @requested_movie_reviews = JSON.parse(review_request.body)["results"]
  end
end

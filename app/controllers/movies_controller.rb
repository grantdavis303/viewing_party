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
    if current_user
      @user = User.find(params[:id])
      movie_id = params["movie_id"]
      request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=0f7ff543b9146c27bb69c85b227e5f63&append_to_response=credits,reviews")
      parsed_json = JSON.parse(request.body)
      @requested_movie = parsed_json
      @requested_movie_cast = parsed_json["credits"]["cast"][0...10]
      @requested_movie_reviews = parsed_json["reviews"]["results"]      
    else
      flash[:message] = "You must be logged in or registered to access this page"
      redirect_to "/"
    end

  end

  def similar
    @user = User.find(params[:id])
    movie_id = params["movie_id"]
    request = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}/similar?api_key=0f7ff543b9146c27bb69c85b227e5f63")
    parsed_json = JSON.parse(request.body)
    @similar_movies = parsed_json
  end
end
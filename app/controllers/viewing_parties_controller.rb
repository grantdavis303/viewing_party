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
    binding.pry

    #<ActionController::Parameters {"authenticity_token"=>"6dwMEU9NrPfuQKeZDlDMpgXXR3H51rf8mN5Cz0c0xAx3IW4N3JRdWmjmstXyh6orzAYAAZwZ0UgwJXDPwmNG2g", "party_duration"=>"126", "party_date"=>"2024-05-30", "game"=>{"game_time(4i)"=>"13", "game_time(5i)"=>"15"}, "guest_1"=>"freddy@sanford-balistreri.test", "commit"=>"Create Party", "controller"=>"viewing_parties", "action"=>"create", "id"=>"10", "movie_id"=>"746036"} permitted: false>

    # ViewingParty.create!(
    #   duration: params[:party_duration], 
    #   date: params[:party_date], 
    #   start_time: "#{params["game"]["game_time(4i)"].to_i}:#{params["game"]["game_time(5i)"].to_i}"
    # )

    # redirect_to "/users/#{params[:id]}"
  end
end
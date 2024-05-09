class UserPartiesController < ApplicationController
  def create
    @user = User.find(params[:user_id].to_i)
    @viewing_party = ViewingParty.find(params[:vp_id].to_i)
    @guests = JSON.parse(params[:guests])

    # Create UserParty Connection for Host
    UserParty.create!(
      viewing_party: @viewing_party, 
      user: @user, 
      host: true
    )

    # Create UserParty Connections for Guest(s)
    @guests.each do |guest_id|
      party_guest = User.find(guest_id)
      UserParty.create!(
        viewing_party: @viewing_party, 
        user: party_guest, 
        host: false
      )      
    end

    redirect_to "/users/#{@user.id}"
  end
end
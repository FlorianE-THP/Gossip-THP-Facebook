class CityController < ApplicationController
  def show
    @cityfind = City.find(params[:id])
    @users = User.where(city: @cityfind)
    @gossips = Gossip.where(user: @users)
  end
end

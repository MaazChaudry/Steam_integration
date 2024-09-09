class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    steam_service = SteamApiService.new('76561198843477030')
    @games = steam_service.fetch_owned_games
  end

  # def show
  #   # @user = User.find(params[:id])
  #   steam_service = SteamService.new('76561198843477030')

  #   @games = steam_service.fetch_owned_games
  #   @profile = steam_service.fetch_profile

  #   # If you want achievements for a specific game
  #   # @achievements = steam_service.fetch_achievements(app_id)
  # end
end

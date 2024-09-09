class SteamApiService
  include HTTParty
  base_uri 'https://api.steampowered.com'

  def initialize(user)
    @user = user
  end

  def owned_games
    self.class.get('/IPlayerService/GetOwnedGames/v0001/', query: {
                     key: ENV['STEAM_WEB_API_KEY'],
                     steamid: '76561198843477030',
                     format: 'json'
                   })
  end

  def fetch_owned_games
    @steam_id = '76561198843477030'
    url = URI("http://api.steampowered.com/IPlayerService/GetOwnedGames/v1/?key=#{ENV['STEAM_WEB_API_KEY']}&steamid=#{@steam_id}&include_appinfo=true&include_played_free_games=true")
    response = Net::HTTP.get(url)
    games_data = JSON.parse(response)

    if games_data['response'] && games_data['response']['games']
      games_data['response']['games']
    else
      []
    end
  end
end

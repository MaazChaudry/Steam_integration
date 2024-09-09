# app/models/user.rb
class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:steam]

  # Find or create a user from OmniAuth data
  def self.from_omniauth(auth)
    # Find the user by provider and uid
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname # Set the nickname as username
      user.steam_url = auth.info.urls['Steam'] # Optional: Store Steam profile URL
      user.password = Devise.friendly_token[0, 20] # Generate a random password since it's OAuth
    end
  end
end

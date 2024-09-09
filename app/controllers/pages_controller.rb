class PagesController < ApplicationController
  def home
    # Check if user is signed in; if yes, redirect them to their profile
    return unless user_signed_in?

    redirect_to profile_path
  end
end

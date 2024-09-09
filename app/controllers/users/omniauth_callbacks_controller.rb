# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def steam
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    if @user.persisted?
      if @user.email.blank?
        # Redirect to a page where the user can fill in their email
        session[:user_id] = @user.id
        redirect_to email_prompt_path
      else
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Steam') if is_navigational_format?
      end
    else
      session['devise.steam_data'] = auth.except(:extra) # Remove extra data before saving in session
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

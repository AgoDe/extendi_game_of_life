class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "Devi prima autenticarti"
      redirect_to root_path
    end
  end

end

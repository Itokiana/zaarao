class ApplicationController < ActionController::Base
  require "wikipedia"

  include SpacesHelper
  include Pagy::Backend

  skip_before_action :verify_authenticity_token
  
  before_action :set_locale
  before_action :set_space
  before_action :set_wiki_locale
  before_action :check_invitations
  before_action :set_available_users

  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def set_locale
    if defined?(params) && params[:locale]
      I18n.locale = params[:locale]
    elsif user_signed_in?
      I18n.locale = current_user.language.code
    end
    I18n.default_locale = :fr
    I18n.locale ||= I18n.default_locale
  end

  def set_wiki_locale
    if I18n.locale.to_s == "mg"
      @domain = 'fr.wikipedia.org'
    else
      @domain = I18n.locale.to_s + '.wikipedia.org'
    end
    Wikipedia.configure {
      domain @domain
      path   'w/api.php'
    }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :firstname, :lastname, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :firstname, :lastname, :birthdate, :language_id, :gender, :password, :password_confirmation, :current_password])
  end

  def check_invitations
    if user_signed_in? && current_user.has_unread_invitations?
      @invitation = current_user.last_invitation
    end
  end

  def set_available_users
    @users = current_space.members
    @available_users = User.all.select { |user| !@users.include?user }
  end
end

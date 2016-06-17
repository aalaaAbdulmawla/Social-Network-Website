class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, 
    						    :email, :password, :password_confirmation,
    							 :phone_num, :gender, 
    							:birthdate, :avatar, 
    						    :hometown, :marital_status, :about]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, 
    						    :email, :password, :password_confirmation,
    							:current_password, :phone_num, :gender, 
    							:birthdate, :remove_avatar, :avatar, :avatar_cache, 
    						    :hometown, :marital_status, :about]
    devise_parameter_sanitizer.for(:sign_in) << [:email, :remember_me]
  end
end

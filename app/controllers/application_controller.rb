class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, 
    							:phone_num, :email, :password, :password_confirmation,
    						    :gender, :birthdate, :hometown, :about, :marital_status,
    							:avatar]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, 
    							:phone_num, :email, :password_confirmation,
    						    :gender, :birthdate, :hometown, :about, :marital_status,
    							:avatar_cache, :remove_avatar, :avatar]
    devise_parameter_sanitizer.for(:sign_in) << [:email, :remember_me]
  end

 

end

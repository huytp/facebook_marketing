class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!
  before_action :author!
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)  << [:first_name, :last_name]
  end
  def author!
    if (params[:controller] != 'devise/sessions') &&  (params[:controller] != 'devise/registrations')
      if current_user.admin?
        return
      else
        render :inline => "You are don't have access right! Please contact 0974 044 308 "
      end
    end
  end

end

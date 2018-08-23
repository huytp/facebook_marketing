class Api::V1::BaseApiController < ActionController::Base
  before_action :api_authenticate_user!, except: :routing_error

  def render_error(error_code = ERROR_CODES[:unknown])
    render json: {success: false, error_code: error_code} and return
  end

  def render_exception_error(exception)
    case exception.class.name
    when Apipie::ParamMissing.name
      render_error ERROR_CODES[:params_missing]
    when Apipie::ParamInvalid.name
      render_error ERROR_CODES[:params_invalid]
    else
      render_error_basic(exception)
    end
  end

  def render_error_basic(exception, error_code = ERROR_CODES[:unknown])
    render_error error_code
  end

  def routing_error
    raise ActionController::RoutingError.new(request.url)
  end

  rescue_from ActionController::RoutingError do |exception|
    render_error(ERROR_CODES[:url_not_found])
  end

  unless Rails.env.development?
    rescue_from StandardError, :with => :render_exception_error
  end

  private
    def current_user
      auth_token = get_authentication_info
      @current_user = (auth_token == ENV["api_key"] ? true : false)
    end

    def api_authenticate_user!
      @current_user = current_user
      render_error ERROR_CODES[:authentication_invalid] unless @current_user
    end

    def get_authentication_info
      params[:api_token]
    end
end

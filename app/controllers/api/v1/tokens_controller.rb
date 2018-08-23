class Api::V1::TokensController < Api::V1::BaseApiController
  api! "get token full permission"
  param :api_token, String, required: true, desc: 'authentication token'
  param :email, String, required: true, desc: 'email'
  param :password, String, required: true, desc: 'password'
  description <<-EOS
    ==Attention:
      . User login required: Yes
    ==Output:
      "response": {
        "session_key": "5.Vm8bWLWySWYnIg.1471505741.67-100009609904593"
        "uid": 100009609904593
        "secret": "e22d13ffd562c56d2274006046e6eadd"
        "access_token": "EAAAAUaZA8jlABAHlWIbbxdNAPKxdIZAM5C2J2Je9UkXuufZA7cPDt1McBx2lILCZCvdhiQiLsAnWtjYhCZBvXO5ghxcvZBGaT5IZBqmoAavZB6FspKkDAnp1Qr5aFILZCrYPbYTnltkAaELDTlJcDVDNEiCpFt5m9PyzVO0JcPVqOnwZDZD"
        "machine_id": "TWW1V4Wcxk74CsIJtvYuPQWx"
      }
  EOS
  def get_token_facebook
    require 'curl'
    data = {
      api_key: "882a8490361da98702bf97a021ddc14d",
      credentials_type: "password",
      email: params[:email],
      format: "JSON",
      generate_machine_id: "1",
      generate_session_cookies: "1",
      locale: "en_US",
      method: "auth.login",
      password: params[:password],
      return_ssl_resources: "0",
      v: "1.0"
    }
    token_service.sign_creator data
    url = BASE_URL + "?" + token_service.http_build_query(data)
    curl = CURL.new
    page = JSON.parse curl.get(url)
    render json: {response: page} and return
  end
  private
    def token_service
      @token_service ||= ::TokenService.new
    end
end
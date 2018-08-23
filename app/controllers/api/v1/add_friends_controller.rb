class Api::V1::AddFriendsController < Api::V1::BaseApiController
  api! "get token full permission"
  param :api_token, String, required: true, desc: 'authentication token'
  param :access_token, String, required: true, desc: 'access token'
  param :gid, String, required: true, desc: 'group ID'
  description <<-EOS
    ==Attention:
      . User login required: Yes
      . Access_token from facebook
      . Group ID
    ==Output:
      {"success":true,"response":true}
  EOS
  def invite_friend
    require 'curl'
    require 'rest-client'
    url = BASE_URL_GET_FRIEND + "&access_token=" + params[:access_token]
    curl = CURL.new
    page = JSON.parse curl.get(url)
    ids = []
    page["friends"]["data"].each{ |x|
      ids.push(x["id"])
    }
    n = ids.count
    i = 0
    while i < n
      puts i
      begin
        response = RestClient.post "https://graph.facebook.com/#{params[:gid]}/members", member: ids[i], access_token: params[:access_token]
      rescue
        i += 1
        next
        if i = n-1
          return
        end
      end
      i += 1
    end
    render json: {success: true, response: response} and return
  end
  private
    def token_service
      @token_service ||= ::TokenService.new
    end
end
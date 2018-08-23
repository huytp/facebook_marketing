class UserSellsController < ApplicationController
  before_filter "save_my_previous_url", only: [:show]
  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end
  def show
    user_id = params[:user_id]
    @user = User.find(user_id)
    @detail_sells = @user.user_sells
  end
end

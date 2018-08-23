class UserInfosController < ApplicationController
  def index
    @users = User.all
  end
end

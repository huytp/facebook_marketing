class HomesController < ApplicationController
  def index
    @customers_valid = Customer.where("expired_time >= ? AND ban = ?", Time.now, false)
    @customers_invalid = Customer.where("expired_time < ?", Time.now)
    @customers_ban = Customer.where(ban: true)
    if params[:key].present?
      @customers = Customer.where("phone = ? OR mac = ?", params[:key], params[:key])
    end
  end

  def ban
    id = params[:id]
    if home_service.ban_unban(id, true)
      flash[:notice] = "Cấm thành công!"
      redirect_to root_path
    else
      flash[:error] = "Cấm lỗi"
    end
  end

  def unban
   id = params[:id]
    if home_service.ban_unban(id, false)
      flash[:notice] = "Bỏ chặn thành công!"
      redirect_to root_path
    else
      flash[:error] = "Bỏ chặn lỗi"
    end
  end

  def update_version
    @current_version = Version.last
    @current_version = @current_version.present? ? @current_version.version : "v1"
  end

  def update_version_value
    version = params[:version]
    @current_version = Version.last
    if @current_version.present?
      @current_version.update_attributes(version: version)
    else
      Version.create(version: version)
    end
    flash[:notice] = "Update thành công!"
    redirect_to update_version_homes_path
  end

  def inform
    @content = Inform.last
    @content = @content.present? ? @content.content : ""
  end

  def inform_value
    param_content = params[:content]
    content = Inform.last
    if content.present?
      content.update_attributes(content: param_content)
    else
      Inform.create(content: param_content)
    end
    flash[:notice] = "Gửi thông báo thành công!"
    redirect_to inform_homes_path
  end

  private
    def home_service
      @home_service ||= ::HomeService.new
    end

end

class Api::V1::CustomersController < Api::V1::BaseApiController
  api! "Create customer"
  param :mac, String, required: true, desc: 'MAC'
  param :full_name, String, required: true, desc: 'Full Name'
  param :email, String, required: true, desc: 'Email'
  param :phone, String, required: true, desc: 'Phone number'
  param :api_token, String, required: true, desc: 'authentication token'
  description <<-EOS
    ==Attention:
      . User login required: Yes
    ==Output:
      {
        "id": 4
        "mac": "12345678"
        "expired_time": "2016-08-11T08:19:15.530Z"
        "user_id": null
        "full_name": "Nick"
        "email": "nick@sagodev.com"
        "phone": "0974 044 308"
        "ban": false
        "created_at": "2016-08-08T08:19:15.530Z"
        "updated_at": "2016-08-08T08:19:15.530Z"
      }
  EOS
  def create
    mac = Customer.where(mac: params[:mac])
    unless mac.present?
      @customer = Customer.new(get_params)
      @customer.expired_time = 3.days.from_now
      if @customer.save
        respond_to do |format|
          format.json { render json: @customer }
        end
      else
        render_error ERROR_CODES[:create_error]
      end
    else
      render_error ERROR_CODES[:create_error]
    end
  end

  api! "get_current_version"
  param :api_token, String, required: true, desc: 'authentication token'
  description <<-EOS
    ==Attention:
      . User login required: Yes
    ==Output:
      {
        "success": true
        "current_version": "v1"
      }
  EOS
  def get_current_version
    current_version = Version.last
    current_version = @current_version.present? ? @current_version.version : "v1"
    render json: {success: true, current_version: current_version} and return
  end


  api! "Check is member? "
  param :mac, String, required: true, desc: 'MAC'
  param :api_token, String, required: true, desc: 'authentication token'
  description <<-EOS
    ==Attention:
      . User login required: Yes
      . Mac required: True
    ==Output:
      {
        "success": true
        "is_member": "true"
      }
  EOS
  def check_is_member
    mac = params[:mac]
    customer = Customer.find_by_mac(mac)
    if customer.present?
      render json: {success: true, is_member: true} and return
    else
      render json: {success: true, is_member: false} and return
    end
  end

  api! "Check is member valid? "
  param :mac, String, required: true, desc: 'MAC'
  param :api_token, String, required: true, desc: 'authentication token'
  description <<-EOS
    ==Attention:
      . User login required: Yes
      . Mac required: True
    ==Output:
      {
        "success": true
        "check_is_member_valid": false
      }
      {
        "id": 9
        "mac": "1234567890"
        "expired_time": "2016-08-11T09:46:56.405Z"
        "user_id": null
        "full_name": "Tran Phu Huy"
        "email": "huytp.uit@gmail.com"
        "phone": "0974 044 308"
        "ban": false
        "created_at": "2016-08-08T09:46:56.408Z"
        "updated_at": "2016-08-10T00:38:13.051Z"
      }
  EOS

  def check_is_member_valid
    mac = params[:mac]
    @customer = Customer.where("mac = ? AND ban = ? AND expired_time >= ?", mac, false, Time.now)
    if @customer.present?
      respond_to do |format|
        format.json { render json: @customer }
      end
    else
      render json: {success: true, check_is_member_valid: false} and return
    end
  end

  api! "Get inform"
  param :api_token, String, required: true, desc: 'authentication token'
  description <<-EOS
    ==Attention:
      . User login required: Yes
    ==Output:
      {
        "success": true
        "inform_content": "huy's inform"
      }
  EOS
  def get_inform
    content = Inform.last
    content = content.present? ? content.content : ""
    render json: {success: true, inform_content: content} and return
  end

  def get_times
    time = Time.now.in_time_zone("Asia/Ho_Chi_Minh")
    render json: {success: true, current_time: time} and return
  end

  private
    def get_params
      params.permit(:mac, :full_name, :email, :phone, :version)
    end

end

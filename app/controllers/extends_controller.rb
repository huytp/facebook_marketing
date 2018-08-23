class ExtendsController < ApplicationController
  before_filter "save_my_previous_url", only: [:show]
  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || '').path
  end
  def show
    customer_id = params[:customer_id]
    @customer = Customer.find(customer_id)
    @service_tables = ServiceTable.all
  end

  def update
    day_of_use = params[:day_of_use]
    price = ServiceTable.where(day_of_use: day_of_use).last.price
    customer_id = params[:customer_id]
    customer = Customer.find(customer_id)
    if customer.expired_time < Time.now
      customer.update_attributes(expired_time: Time.now + day_of_use.to_i.days)
    else
      customer.update_attributes(expired_time: customer.expired_time + day_of_use.to_i.days)
    end
    current_user.user_sells.create(customer_id: customer_id, price: price)
    flash[:notice] = "Gia hạn thành công"
    redirect_to homes_path
  end
end

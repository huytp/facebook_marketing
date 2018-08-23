class HomeService
  def ban_unban(id, value)
    customer = Customer.find(id)
    customer.ban = value
    customer.save
  end
end
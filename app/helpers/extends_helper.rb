module ExtendsHelper
  def get_service_tables service_tables
    service_tables.select(:day_of_use, :price).collect {|n| [number_to_currency(n.price, precision: 0, unit: "đồng", format: "%n %u"), n.day_of_use]}
  end
end

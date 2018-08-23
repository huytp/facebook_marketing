require 'test_helper'

class ServiceTablesControllerTest < ActionController::TestCase
  setup do
    @service_table = service_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_table" do
    assert_difference('ServiceTable.count') do
      post :create, service_table: { day_of_use: @service_table.day_of_use, price: @service_table.price }
    end

    assert_redirected_to service_table_path(assigns(:service_table))
  end

  test "should show service_table" do
    get :show, id: @service_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_table
    assert_response :success
  end

  test "should update service_table" do
    patch :update, id: @service_table, service_table: { day_of_use: @service_table.day_of_use, price: @service_table.price }
    assert_redirected_to service_table_path(assigns(:service_table))
  end

  test "should destroy service_table" do
    assert_difference('ServiceTable.count', -1) do
      delete :destroy, id: @service_table
    end

    assert_redirected_to service_tables_path
  end
end

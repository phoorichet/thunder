require 'test_helper'

class ReturnsControllerTest < ActionController::TestCase
  setup do
    @return = returns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:returns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create return" do
    assert_difference('Return.count') do
      post :create, return: { age: @return.age, amount: @return.amount, year: @return.year }
    end

    assert_redirected_to return_path(assigns(:return))
  end

  test "should show return" do
    get :show, id: @return
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @return
    assert_response :success
  end

  test "should update return" do
    patch :update, id: @return, return: { age: @return.age, amount: @return.amount, year: @return.year }
    assert_redirected_to return_path(assigns(:return))
  end

  test "should destroy return" do
    assert_difference('Return.count', -1) do
      delete :destroy, id: @return
    end

    assert_redirected_to returns_path
  end
end

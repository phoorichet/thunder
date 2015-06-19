require 'test_helper'

class ProtectionsControllerTest < ActionController::TestCase
  setup do
    @protection = protections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:protections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create protection" do
    assert_difference('Protection.count') do
      post :create, protection: { age: @protection.age, amount: @protection.amount, year: @protection.year }
    end

    assert_redirected_to protection_path(assigns(:protection))
  end

  test "should show protection" do
    get :show, id: @protection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @protection
    assert_response :success
  end

  test "should update protection" do
    patch :update, id: @protection, protection: { age: @protection.age, amount: @protection.amount, year: @protection.year }
    assert_redirected_to protection_path(assigns(:protection))
  end

  test "should destroy protection" do
    assert_difference('Protection.count', -1) do
      delete :destroy, id: @protection
    end

    assert_redirected_to protections_path
  end
end

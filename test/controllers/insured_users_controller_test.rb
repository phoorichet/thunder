require 'test_helper'

class InsuredUsersControllerTest < ActionController::TestCase
  setup do
    @insured_user = insured_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insured_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insured_user" do
    assert_difference('InsuredUser.count') do
      post :create, insured_user: { first_name: @insured_user.first_name, gender: @insured_user.gender, last_name: @insured_user.last_name }
    end

    assert_redirected_to insured_user_path(assigns(:insured_user))
  end

  test "should show insured_user" do
    get :show, id: @insured_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insured_user
    assert_response :success
  end

  test "should update insured_user" do
    patch :update, id: @insured_user, insured_user: { first_name: @insured_user.first_name, gender: @insured_user.gender, last_name: @insured_user.last_name }
    assert_redirected_to insured_user_path(assigns(:insured_user))
  end

  test "should destroy insured_user" do
    assert_difference('InsuredUser.count', -1) do
      delete :destroy, id: @insured_user
    end

    assert_redirected_to insured_users_path
  end
end

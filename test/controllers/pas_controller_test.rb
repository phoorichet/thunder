require 'test_helper'

class PasControllerTest < ActionController::TestCase
  setup do
    @pa = pas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pa" do
    assert_difference('Pa.count') do
      post :create, pa: { book_id: @pa.book_id, description: @pa.description, name: @pa.name, pa_type: @pa.pa_type, reference_id: @pa.reference_id, status: @pa.status }
    end

    assert_redirected_to pa_path(assigns(:pa))
  end

  test "should show pa" do
    get :show, id: @pa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pa
    assert_response :success
  end

  test "should update pa" do
    patch :update, id: @pa, pa: { book_id: @pa.book_id, description: @pa.description, name: @pa.name, pa_type: @pa.pa_type, reference_id: @pa.reference_id, status: @pa.status }
    assert_redirected_to pa_path(assigns(:pa))
  end

  test "should destroy pa" do
    assert_difference('Pa.count', -1) do
      delete :destroy, id: @pa
    end

    assert_redirected_to pas_path
  end
end

require 'test_helper'

class PaCoveragesControllerTest < ActionController::TestCase
  setup do
    @pa_coverage = pa_coverages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pa_coverages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pa_coverage" do
    assert_difference('PaCoverage.count') do
      post :create, pa_coverage: { coverage_type: @pa_coverage.coverage_type, description: @pa_coverage.description, key: @pa_coverage.key, pa_id: @pa_coverage.pa_id, reference_id: @pa_coverage.reference_id, value: @pa_coverage.value }
    end

    assert_redirected_to pa_coverage_path(assigns(:pa_coverage))
  end

  test "should show pa_coverage" do
    get :show, id: @pa_coverage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pa_coverage
    assert_response :success
  end

  test "should update pa_coverage" do
    patch :update, id: @pa_coverage, pa_coverage: { coverage_type: @pa_coverage.coverage_type, description: @pa_coverage.description, key: @pa_coverage.key, pa_id: @pa_coverage.pa_id, reference_id: @pa_coverage.reference_id, value: @pa_coverage.value }
    assert_redirected_to pa_coverage_path(assigns(:pa_coverage))
  end

  test "should destroy pa_coverage" do
    assert_difference('PaCoverage.count', -1) do
      delete :destroy, id: @pa_coverage
    end

    assert_redirected_to pa_coverages_path
  end
end

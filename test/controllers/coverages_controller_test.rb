require 'test_helper'

class CoveragesControllerTest < ActionController::TestCase
  setup do
    @coverage = coverages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coverages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coverage" do
    assert_difference('Coverage.count') do
      post :create, coverage: { abbr: @coverage.abbr, category: @coverage.category, coverage_amount: @coverage.coverage_amount, coverage_end_at: @coverage.coverage_end_at, coverage_unit: @coverage.coverage_unit, description: @coverage.description, master_rider_id: @coverage.master_rider_id, name: @coverage.name, premium_amount: @coverage.premium_amount, premium_unit: @coverage.premium_unit, rider_id: @coverage.rider_id }
    end

    assert_redirected_to coverage_path(assigns(:coverage))
  end

  test "should show coverage" do
    get :show, id: @coverage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coverage
    assert_response :success
  end

  test "should update coverage" do
    patch :update, id: @coverage, coverage: { abbr: @coverage.abbr, category: @coverage.category, coverage_amount: @coverage.coverage_amount, coverage_end_at: @coverage.coverage_end_at, coverage_unit: @coverage.coverage_unit, description: @coverage.description, master_rider_id: @coverage.master_rider_id, name: @coverage.name, premium_amount: @coverage.premium_amount, premium_unit: @coverage.premium_unit, rider_id: @coverage.rider_id }
    assert_redirected_to coverage_path(assigns(:coverage))
  end

  test "should destroy coverage" do
    assert_difference('Coverage.count', -1) do
      delete :destroy, id: @coverage
    end

    assert_redirected_to coverages_path
  end
end

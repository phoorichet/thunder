require 'test_helper'

class MasterCoveragesControllerTest < ActionController::TestCase
  setup do
    @master_coverage = master_coverages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_coverages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_coverage" do
    assert_difference('MasterCoverage.count') do
      post :create, master_coverage: { abbr: @master_coverage.abbr, category: @master_coverage.category, coverage_amount: @master_coverage.coverage_amount, coverage_end_at: @master_coverage.coverage_end_at, coverage_unit: @master_coverage.coverage_unit, description: @master_coverage.description, master_rider_id: @master_coverage.master_rider_id, name: @master_coverage.name, premium_amount: @master_coverage.premium_amount, premium_unit: @master_coverage.premium_unit }
    end

    assert_redirected_to master_coverage_path(assigns(:master_coverage))
  end

  test "should show master_coverage" do
    get :show, id: @master_coverage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_coverage
    assert_response :success
  end

  test "should update master_coverage" do
    patch :update, id: @master_coverage, master_coverage: { abbr: @master_coverage.abbr, category: @master_coverage.category, coverage_amount: @master_coverage.coverage_amount, coverage_end_at: @master_coverage.coverage_end_at, coverage_unit: @master_coverage.coverage_unit, description: @master_coverage.description, master_rider_id: @master_coverage.master_rider_id, name: @master_coverage.name, premium_amount: @master_coverage.premium_amount, premium_unit: @master_coverage.premium_unit }
    assert_redirected_to master_coverage_path(assigns(:master_coverage))
  end

  test "should destroy master_coverage" do
    assert_difference('MasterCoverage.count', -1) do
      delete :destroy, id: @master_coverage
    end

    assert_redirected_to master_coverages_path
  end
end

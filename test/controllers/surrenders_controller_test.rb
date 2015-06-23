require 'test_helper'

class SurrendersControllerTest < ActionController::TestCase
  setup do
    @surrender = surrenders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surrenders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create surrender" do
    assert_difference('Surrender.count') do
      post :create, surrender: { assured_age: @surrender.assured_age, cv: @surrender.cv, ecv: @surrender.ecv, eti: @surrender.eti, eti_day: @surrender.eti_day, eti_year: @surrender.eti_year, etipe: @surrender.etipe, rpu: @surrender.rpu, surrender_type: @surrender.surrender_type, year: @surrender.year }
    end

    assert_redirected_to surrender_path(assigns(:surrender))
  end

  test "should show surrender" do
    get :show, id: @surrender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @surrender
    assert_response :success
  end

  test "should update surrender" do
    patch :update, id: @surrender, surrender: { assured_age: @surrender.assured_age, cv: @surrender.cv, ecv: @surrender.ecv, eti: @surrender.eti, eti_day: @surrender.eti_day, eti_year: @surrender.eti_year, etipe: @surrender.etipe, rpu: @surrender.rpu, surrender_type: @surrender.surrender_type, year: @surrender.year }
    assert_redirected_to surrender_path(assigns(:surrender))
  end

  test "should destroy surrender" do
    assert_difference('Surrender.count', -1) do
      delete :destroy, id: @surrender
    end

    assert_redirected_to surrenders_path
  end
end

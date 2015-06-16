require 'test_helper'

class PersonsControllerTest < ActionController::TestCase
  setup do
    @person = persons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:persons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { date_of_birth: @person.date_of_birth, first_name: @person.first_name, gender: @person.gender, height: @person.height, income: @person.income, is_smoking: @person.is_smoking, last_name: @person.last_name, marital_status: @person.marital_status, national_id: @person.national_id, occupation: @person.occupation, passport_id: @person.passport_id, person_type: @person.person_type, spouse_id: @person.spouse_id, weight: @person.weight }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    patch :update, id: @person, person: { date_of_birth: @person.date_of_birth, first_name: @person.first_name, gender: @person.gender, height: @person.height, income: @person.income, is_smoking: @person.is_smoking, last_name: @person.last_name, marital_status: @person.marital_status, national_id: @person.national_id, occupation: @person.occupation, passport_id: @person.passport_id, person_type: @person.person_type, spouse_id: @person.spouse_id, weight: @person.weight }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to persons_path
  end
end

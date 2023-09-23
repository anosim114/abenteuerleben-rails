require "test_helper"

class CampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campyear = campyears(:one)
    @camp = camps(:one)

    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
  end

  test "should be redirected to homepage if not admin" do
    # prepare
    get '/logout'

    # execute
    get camps_url(@campyear)

    # check
    assert_redirected_to root_url
  end

  test "should get index" do
    get camps_url
    assert_response :success
  end

  test "should get new" do
    get new_campyear_camp_url(@campyear)
    assert_response :success
  end

  test "should redirect if campyear param is invalid" do
    get new_campyear_camp_url(123)
    assert_response :redirect
  end

  test "should create camp" do
    assert_difference("Camp.count") do
      post campyear_camps_url(@campyear), params: { camp: { campyear_id: @camp.campyear_id, date_end: @camp.date_end, date_start: @camp.date_start, max_participant_count: @camp.max_participant_count, participants_year_end: @camp.participants_year_end, participants_year_start: @camp.participants_year_start } }
    end

    assert_redirected_to campyear_camp_url(Camp.last.campyear, Camp.last)
  end

  test "should show camp" do
    get campyear_camp_url(@campyear, @camp)
    assert_response :success
  end

  test "should get edit" do
    get edit_campyear_camp_url(@campyear, @camp)
    assert_response :success
  end

  test "should update camp" do
    patch campyear_camp_url(@campyear, @camp), params: { camp: { campyear_id: @camp.campyear_id, date_end: @camp.date_end, date_start: @camp.date_start, max_participant_count: @camp.max_participant_count, participants_year_end: @camp.participants_year_end, participants_year_start: @camp.participants_year_start } }
    assert_redirected_to campyear_camp_url(@campyear, @camp)
  end

  test "should destroy camp" do
    assert_difference("Camp.count", -1) do
      delete campyear_camp_url(@campyear, @camp)
    end

    assert_redirected_to campyear_url(@campyear)
  end
end

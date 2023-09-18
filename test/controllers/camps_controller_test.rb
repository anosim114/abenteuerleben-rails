require "test_helper"

class CampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camp = camps(:one)
  end

  test "should get index" do
    get camps_url
    assert_response :success
  end

  test "should get new" do
    get new_camp_url, params: {campyear: campyears(:one).id}
    assert_response :success
  end

  test "should redirect campyears" do
    get new_camp_url
    assert_response :redirect
  end

  test "should create camp" do
    assert_difference("Camp.count") do
      post camps_url, params: { camp: { campyear_id: @camp.campyear_id, date_end: @camp.date_end, date_start: @camp.date_start, max_participant_count: @camp.max_participant_count, participants_year_end: @camp.participants_year_end, participants_year_start: @camp.participants_year_start } }
    end

    assert_redirected_to camp_url(Camp.last)
  end

  test "should show camp" do
    get camp_url(@camp)
    assert_response :success
  end

  test "should get edit" do
    get edit_camp_url(@camp)
    assert_response :success
  end

  test "should update camp" do
    patch camp_url(@camp), params: { camp: { campyear_id: @camp.campyear_id, date_end: @camp.date_end, date_start: @camp.date_start, max_participant_count: @camp.max_participant_count, participants_year_end: @camp.participants_year_end, participants_year_start: @camp.participants_year_start } }
    assert_redirected_to camp_url(@camp)
  end

  test "should destroy camp" do
    assert_difference("Camp.count", -1) do
      delete camp_url(@camp)
    end

    assert_redirected_to camps_url
  end
end

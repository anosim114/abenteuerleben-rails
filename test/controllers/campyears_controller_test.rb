require "test_helper"

class CampyearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campyear = campyears(:one)
  end

  test "should get index" do
    get campyears_url
    assert_response :success
  end

  test "should get new" do
    get new_campyear_url
    assert_response :success
  end

  test "should create campyear" do
    assert_difference("Campyear.count") do
      post campyears_url, params: { campyear: { accentcolor_primary: @campyear.accentcolor_primary, accentcolor_secondary: @campyear.accentcolor_secondary, helper_register_end: @campyear.helper_register_end, helper_register_start: @campyear.helper_register_start, participants_register_end: @campyear.participants_register_end, participants_register_start: @campyear.participants_register_start, year: @campyear.year } }
    end

    assert_redirected_to campyear_url(Campyear.last)
  end

  test "should show campyear" do
    get campyear_url(@campyear)
    assert_response :success
  end

  test "should get edit" do
    get edit_campyear_url(@campyear)
    assert_response :success
  end

  test "should update campyear" do
    patch campyear_url(@campyear), params: { campyear: { accentcolor_primary: @campyear.accentcolor_primary, accentcolor_secondary: @campyear.accentcolor_secondary, helper_register_end: @campyear.helper_register_end, helper_register_start: @campyear.helper_register_start, participants_register_end: @campyear.participants_register_end, participants_register_start: @campyear.participants_register_start, year: @campyear.year } }
    assert_redirected_to campyear_url(@campyear)
  end

  test "should destroy campyear" do
    @campyear = campyears(:three)
    assert_difference("Campyear.count", -1) do
      delete campyear_url(@campyear)
    end

    assert_redirected_to campyears_url
  end
end

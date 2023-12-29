require 'test_helper'

class CampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campyear = campyears(:one)
    @camp = camps(:one)
    @camp2 = camps(:two)

    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
  end

  test 'should be redirected to homepage if not admin' do
    # prepare
    get '/logout'

    # execute
    get campyear_camps_url(@camp.campyear)

    # check
    assert_redirected_to root_url
  end

  test 'should get index' do
    get campyear_camps_url(@camp.campyear)
    assert_response :success
  end

  test 'should get new' do
    get new_campyear_camp_url(@camp.campyear)
    assert_response :success
  end

  test 'should redirect if campyear param is invalid' do
    get new_campyear_camp_url(123)
    assert_response :redirect
  end

  test 'should create camp' do
    assert_difference('Camp.count') do
      post campyear_camps_url(@campyear),
           params: { camp: {
             campyear_id: @campyear.id,
             name: @camp.name,
             date_end: @camp.date_end,
             date_start: @camp.date_start,
             max_participant_count: @camp.max_participant_count,
             participants_year_end: @camp.participants_year_end,
             participants_year_start: @camp.participants_year_start,
             price: @camp.price
           } }
    end

    assert_redirected_to camp_url(Camp.last)
  end

  test 'should show camp' do
    get camp_url(@camp)
    assert_response :success
  end

  test 'should get edit' do
    get edit_camp_url(@camp)
    assert_response :success
  end

  test 'should update camp' do
    patch camp_url(@camp),
          params: { camp: {
            campyear_id: @camp.campyear_id,
            name: @camp.name,
            date_end: @camp.date_end,
            date_start: @camp2.date_start,
            max_participant_count: @camp2.max_participant_count,
            participants_year_end: @camp2.participants_year_end,
            participants_year_start: @camp2.participants_year_start,
            price: @camp2.price
          } }
    assert_redirected_to camp_url(@camp)
  end

  test 'should destroy camp' do
    assert_difference('Camp.count', -1) do
      delete camp_url(@camp)
    end

    assert_redirected_to campyear_url(@campyear)
  end
end

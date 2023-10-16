require "test_helper"

class HelpersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @helper = helpers(:one)

    post '/login', params: { 'user[name]': users(:admin).name, 'user[password]': 'admin' }
  end

  test "should get index" do
    get helpers_url
    assert_response :success
  end

  test "should get new" do
    get new_helper_url
    assert_response :success
  end

  test "should create helper" do
    assert_difference("Helper.count") do
      post helpers_url, params: {
        helper: {
          surname: @helper.surname,
          forename: @helper.forename,
          birthday: @helper.birthday,
          birthplace: @helper.birthplace,
          telephone: @helper.telephone,
          email: @helper.email,

          streethouse: @helper.streethouse,
          postcity: @helper.postcity,

          story: @helper.story,
          duty: @helper.duty,
          registrations_attributes: [
            {
              camp_id: camps(:one).id,
              participate: registrations(:one).participate,
              wish_first: registrations(:one).wish_first,
              wish_second: registrations(:one).wish_second
            },
            {
              camp_id: camps(:two).id,
              participate: registrations(:two).participate,
              wish_first: registrations(:two).wish_first,
              wish_second: registrations(:two).wish_second
            }
          ]
        }
      }
    end

    assert_redirected_to root_url
  end

  test "should show helper" do
    get helper_url(@helper)
    assert_response :success
  end

  test "should get edit" do
    get edit_helper_url(@helper)
    assert_response :success
  end

  test "should update helper" do
    patch helper_url(@helper), params: {
      helper: {
        surname: @helper.surname,
        forename: @helper.forename,
        telephone: @helper.telephone,
        email: @helper.email,
        birthday: @helper.birthday,
        birthplace: @helper.birthplace,

        streethouse: @helper.streethouse,
        postcity: @helper.postcity,

        story: @helper.story,
        duty: @helper.duty
      }
    }
    assert_redirected_to helper_url(@helper)
  end

  test "should destroy helper" do
    assert_difference("Helper.count", -1) do
      delete helper_url(@helper)
    end

    assert_redirected_to helpers_url
  end
end

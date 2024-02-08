require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test 'visiting the homepage' do
    visit root_path
    assert_selector "h1", text: "Abenteuer Leben e.V."
  end
  #
  # test 'visiting the homepage while logged in' do
  #   logging_in
  #
  #   visit root_path
  #
  #   assert_selector "h1", text: "Abenteuer Leben e.V."
  #   assert_text 'Admin Dashboard'
  #   assert_text 'Logout'
  # end

  # test 'logging in' do
  # end
end
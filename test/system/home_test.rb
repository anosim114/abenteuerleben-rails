require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test 'visiting the homepage' do
    visit root_path
    assert_selector "h1", text: "Abenteuer Leben e.V."
  end
end
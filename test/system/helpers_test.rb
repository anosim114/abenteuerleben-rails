require "application_system_test_case"

class HelpersTest < ApplicationSystemTestCase
  setup do
    @helper = helpers(:one)
  end

  test "visiting the index" do
    logging_in

    visit helpers_url
    assert_selector "h1", text: "Mitarbeiter"
  end

  test "should not create helper if no camp was selected" do
    visit new_helper_url

    attach_file 'helper_photo', Rails.root.join('test/fixtures/files/avatar.png')

    fill_in "helper_surname", with: @helper.surname
    fill_in "helper_forename", with: @helper.forename
    select '2', from: 'helper_birthday_3i'
    select 'Februar', from: 'helper_birthday_2i'
    select '2003', from: 'helper_birthday_1i'
    fill_in "helper_birthplace", with: @helper.birthplace
    fill_in "helper_telephone", with: @helper.telephone
    fill_in "helper_email", with: @helper.email
    fill_in "helper_streethouse", with: @helper.streethouse
    fill_in "helper_postcity", with: @helper.postcity
    fill_in "helper_story", with: @helper.story
    fill_in "helper_duty", with: @helper.duty

    check "helper_liability_exclusion"
    click_on "Als gelesen markieren"

    check "helper_important_information"
    click_on "Als gelesen markieren"

    click_on "Verbindlich und zahlungspflichtig anmelden"

    assert_text "Mindestend ein Camp muss ausgewählt werden"
  end

  test "should not create Helper with same teams in one camp" do
    visit new_helper_url

    attach_file 'helper_photo', Rails.root.join('test/fixtures/files/avatar.png')

    fill_in "helper_surname", with: @helper.surname
    fill_in "helper_forename", with: @helper.forename
    select '2', from: 'helper_birthday_3i'
    select 'Februar', from: 'helper_birthday_2i'
    select '2003', from: 'helper_birthday_1i'
    fill_in "helper_birthplace", with: @helper.birthplace
    fill_in "helper_telephone", with: @helper.telephone
    fill_in "helper_email", with: @helper.email
    fill_in "helper_streethouse", with: @helper.streethouse
    fill_in "helper_postcity", with: @helper.postcity
    fill_in "helper_story", with: @helper.story
    fill_in "helper_duty", with: @helper.duty

    check 'helper_registrations_attributes_0_participate'
    select 'Küche', from: 'helper_registrations_attributes_0_wish_first'
    select 'Küche', from: 'helper_registrations_attributes_0_wish_second'

    check "helper_liability_exclusion"
    click_on "Als gelesen markieren"

    check "helper_important_information"
    click_on "Als gelesen markieren"

    click_on "Verbindlich und zahlungspflichtig anmelden"

    assert_text "Teamwunsch eins und zwei dürfen nicht das gleiche Team sein"
  end

  test "should create Helper" do
    visit new_helper_url

    attach_file 'helper_photo', Rails.root.join('test/fixtures/files/avatar.png')

    fill_in "helper_surname", with: @helper.surname
    fill_in "helper_forename", with: @helper.forename
    select '2', from: 'helper_birthday_3i'
    select 'Februar', from: 'helper_birthday_2i'
    select '2003', from: 'helper_birthday_1i'
    fill_in "helper_birthplace", with: @helper.birthplace
    fill_in "helper_telephone", with: @helper.telephone
    fill_in "helper_email", with: @helper.email
    fill_in "helper_streethouse", with: @helper.streethouse
    fill_in "helper_postcity", with: @helper.postcity
    fill_in "helper_story", with: @helper.story
    fill_in "helper_duty", with: @helper.duty

    check 'helper_registrations_attributes_0_participate'
    select 'Sportler', from: 'helper_registrations_attributes_0_wish_first'
    select 'Küche', from: 'helper_registrations_attributes_0_wish_second'

    check "helper_liability_exclusion"
    click_on "Als gelesen markieren"

    check "helper_important_information"
    click_on "Als gelesen markieren"

    click_on "Verbindlich und zahlungspflichtig anmelden"

    assert_text 'Erfolgreich als Mitarbeiter angemeldet.'
  end

  # test 'should create helper with self assigned team'
  # end

  # test 'should edit helper'
  # end
end

require "application_system_test_case"

class DownloadsTest < ApplicationSystemTestCase
  setup do
    @download = downloads(:one)
  end

  test "visiting the index" do
    visit downloads_url
    assert_selector "h1", text: "Downloads"
  end

  test "should create download" do
    visit downloads_url
    click_on "New download"

    fill_in "Description", with: @download.description
    check "Download area" if @download.download_area
    fill_in "Name", with: @download.name
    click_on "Create Download"

    assert_text "Download was successfully created"
    click_on "Back"
  end

  test "should update Download" do
    visit download_url(@download)
    click_on "Edit this download", match: :first

    fill_in "Description", with: @download.description
    check "Download area" if @download.download_area
    fill_in "Name", with: @download.name
    click_on "Update Download"

    assert_text "Download was successfully updated"
    click_on "Back"
  end

  test "should destroy Download" do
    visit download_url(@download)
    click_on "Destroy this download", match: :first

    assert_text "Download was successfully destroyed"
  end
end

require "test_helper"

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @download = downloads(:one)
  end

  test "should get index" do
    get downloads_url
    assert_response :success
  end

  test "should get admin index" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
    get downloads_admin_url
    assert_response :success
  end

  test "should get new" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
    get new_download_url
    assert_response :success
  end

  test "should create download" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }

    assert_difference 'Download.count' do
      post downloads_url, params: {
        download: {
          name: 'a new name',
          description: @download.description,
          download_area: @download.download_area
        }
      }
    end

    assert_redirected_to download_url(Download.last)
  end

  test "should show download" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
    get download_url(@download)
    assert_response :success
  end

  test "should get edit" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
    get edit_download_url(@download)
    assert_response :success
  end

  test "should update download" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
    patch download_url(@download), params: { download: { description: @download.description, download_area: @download.download_area, name: @download.name } }
    assert_redirected_to download_url(@download)
  end

  test "should destroy download" do
    post '/login', params: { 'user[name]': 'admin', 'user[password]': 'admin' }
    assert_difference("Download.count", -1) do
      delete download_url(@download)
    end

    assert_redirected_to downloads_admin_url
  end
end

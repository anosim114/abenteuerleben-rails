require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = ENV['DRIVER'] ? ENV["DRIVER"].to_sym : :headless_chrome
  driven_by :selenium, using: DRIVER, screen_size: [1400, 900]

  def logging_in
    admin = users(:admin)
    visit login_url

    fill_in 'user_name', with: admin.name
    fill_in 'user_password', with: admin.password_hash
    click_on 'Anmelden'
  end
end

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 900]

  def logging_in
    admin = users(:admin)
    visit login_url

    fill_in 'user_name', with: admin.name
    fill_in 'user_password', with: admin.password_hash
    click_on 'Anmelden'
  end
end

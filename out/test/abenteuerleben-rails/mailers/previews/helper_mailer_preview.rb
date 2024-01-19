# Preview all emails at http://localhost:3000/rails/mailers/helper_mailer
class HelperMailerPreview < ActionMailer::Preview
  def registered_mail
    helper = Helper.first!

    HelperMailer.with(helper: helper).registered_mail
  end
end

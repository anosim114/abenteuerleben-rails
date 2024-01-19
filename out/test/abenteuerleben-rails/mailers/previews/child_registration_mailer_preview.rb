# Preview all emails at http://localhost:3000/rails/mailers/child_registration_mailer
class ChildRegistrationMailerPreview < ActionMailer::Preview
  def registered_mail
    parent = Parent::Parent.first!

    ChildRegistrationMailer.with(parent:).registered_mail
  end
end

class ChildRegistrationMailer < ApplicationMailer
  def registered_mail
    @parent = params[:parent]

    mail(to: @parent.email, subject: 'Registrierung zum Teencamp')
  end
end

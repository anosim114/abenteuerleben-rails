class ChildRegistrationMailer < ApplicationMailer
  def registered_mail
    @parent = params[:parent]
    @child = params[:child]

    mail(to: @parent.email, subject: 'Registrierung zum Sommercamp')
  end
end

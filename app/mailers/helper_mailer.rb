class HelperMailer < ApplicationMailer
  def registered_mail
    @helper = params[:helper]

    mail(to: @helper.email, subject: 'Registrierung als Mitarbeiter')
  end
end

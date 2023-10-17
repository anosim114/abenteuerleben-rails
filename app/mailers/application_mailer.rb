class ApplicationMailer < ActionMailer::Base
  default from: "Abenteuerleben e.V. <admin@abenteuerleben-ev.de>"

  layout "mailer"
end

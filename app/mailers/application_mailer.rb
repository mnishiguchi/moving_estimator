class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@mnishiguchi.herokuapp.com"
  layout 'mailer'
end

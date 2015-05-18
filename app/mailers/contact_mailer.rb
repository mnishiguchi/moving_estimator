class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.message_from_user.subject
  #
  def message_from_user(contact)
    @message = contact.message

    mail to: "masatoshi.nishiguchi@udc.edu",
         from: contact.email,
         subject: "A message from #{full_name_with_email(contact)}"
  end

  def full_name_with_email(contact)
    %Q("#{contact.first_name} #{contact.last_name}" <#{contact.email}>)
  end
end

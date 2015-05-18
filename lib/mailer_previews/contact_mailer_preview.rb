# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/message_from_user
  def message_from_user
    contact = Contact.new(
      first_name: "Example",
      last_name:  "User",
      email:      "user@exapmle.com",
      message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        Maiores consequuntur vero magnam, voluptatem iusto non dicta obcaecati
        expedita corrupti laudantium nostrum incidunt laboriosam, atque tempore
        rerum nihil, tenetur excepturi corporis.".gsub(/\s+/, " ")
    )
    ContactMailer.message_from_user(contact)
  end
end

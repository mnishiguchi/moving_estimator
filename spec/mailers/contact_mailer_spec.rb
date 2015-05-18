require "rails_helper"

RSpec.describe ContactMailer, :type => :mailer do

  describe "Contact email from user" do

    let(:mail) do
      @contact = Contact.new(first_name: "Example",
                             last_name:  "User",
                             email:      "user@example.com",
                             message:    "Lorem ipsum dolor sit amet.")
      ContactMailer.message_from_user(@contact)
    end

    it "renders the email header" do
      expect(mail.subject).to eq('A message from "Example User" <user@example.com>')
      expect(mail.to).to eq(["masatoshi.nishiguchi@udc.edu"])
      expect(mail.from).to eq([@contact.email])
    end

    it "renders user's message in the body" do
      expect(mail.body.encoded).to match(@contact.message)
    end
  end

end

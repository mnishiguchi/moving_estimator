require "rails_helper"

describe ContactMailer do

  describe "Contact email from user" do

    let(:mail) do
      @user_input = Contact.new(first_name: "Example",
                                last_name:  "User",
                                email:      "user@example.com",
                                message:    "Lorem ipsum dolor sit amet.")
      ContactMailer.message_from_user(@user_input)
    end

    it "renders the header" do
      expect(mail.subject).to eq('A message from "Example User" <user@example.com>')
      expect(mail.to).to eq(["masatoshi.nishiguchi@udc.edu"])
      expect(mail.from).to eq([@user_input.email])
    end

    it "contains user's message in the body" do
      expect(mail.body.encoded).to match(@user_input.message)
    end
  end

end

require 'rails_helper'

describe Contact do

  let(:contact) do
    Contact.new(username: "Masatoshi Nishiguchi",
                email:      "user@example.com",
                message:    "Lorem ipsum dolor sit amet.")
  end

  it { expect(contact).to be_valid }

  it "has non-blank username" do
    contact.username = "  "
    expect(contact).to_not be_valid
    expect(contact).to_not have_error_message
  end

  it "has non-blank email" do
    contact.email = "  "
    expect(contact).to_not be_valid
    expect(contact).to_not have_error_message
  end

  it "has email with at most 255 characters" do
    contact.email = "a" * 256
    expect(contact).to_not be_valid
    expect(contact).to_not have_error_message
  end

  it "has non-blank message" do
    contact.message = "  "
    expect(contact).to_not be_valid
    expect(contact).to_not have_error_message
  end

  it "has message with at most 255 characters" do
    contact.message = "a" * 256
    expect(contact).to_not be_valid
    expect(contact).to_not have_error_message
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        contact.email = invalid_address
        expect(contact).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                      first.last@foo.jp alice+bob@baz.cn)
      addresses.each do |valid_address|
        contact.email = valid_address
        expect(contact).to be_valid
      end
    end
  end
end

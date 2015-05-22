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

  # TODO
  it "rejects invalid email format"
end

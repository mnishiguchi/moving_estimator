require 'rails_helper'

describe Contact do

  let(:contact) do
    Contact.new(first_name: "Masatoshi",
                last_name:  "Nishiguchi",
                email:      "user@example.com",
                message:    "Lorem ipsum dolor sit amet.")
  end

  it "should be valid" do
    expect(contact).to be_valid
  end

  it "has non-blank first name" do
    contact.first_name = "  "
    expect(contact).not_to be_valid
    expect(contact.errors[:first_name]).to include("can't be blank")
  end

  it "has non-blank last name" do
    contact.last_name = "  "
    expect(contact).not_to be_valid
    expect(contact.errors[:last_name]).to include("can't be blank")
  end

  it "has non-blank email" do
    contact.email = "  "
    expect(contact).not_to be_valid
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "has email with at most 255 characters" do
    contact.email = "a" * 255
    expect(contact).not_to be_valid
  end

  it "has non-blank message" do
    contact.message = "  "
    expect(contact).not_to be_valid
    expect(contact.errors[:message]).to include("can't be blank")
  end

  it "rejects invalid email format"
end

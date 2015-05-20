# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  admin                  :boolean          default(FALSE)
#  username               :string
#

require 'rails_helper'

# It would be counter-productive to test Devise itself.
# It already has a comprehensive suite of tests that you are able run yourself,
# should you doubt its efficacy.

describe User do

  before do
    @user = User.new(username: "Example User", email: "user@example.com",
                    password: "password", password_confirmation: "password")
  end

  subject { @user }

  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }



  describe "when email format is invalid" do
    pending
    # it "should be invalid" do
    #   addresses = %w[user@foo,com user_at_foo.org example.user@foo.
    #                  foo@bar_baz.com foo@bar+baz.com]
    #   addresses.each do |invalid_address|
    #     @user.email = invalid_address
    #     expect(@user).not_to be_valid
    #   end
    # end
  end

  describe "when email format is valid" do
    pending
    # it "should be valid" do
    #   addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
    #                   first.last@foo.jp alice+bob@baz.cn)
    #   addresses.each do |valid_address|
    #     @user.email = valid_address
    #     expect(@user).to be_valid
    #   end
    # end
  end

  describe "when email address is already taken (case-insensitive)" do
    pending
    # before do
    #   user_with_same_email = @user.dup
    #   user_with_same_email.email = @user.email.upcase
    #   user_with_same_email.save
    # end
    # it { is_expected.not_to be_valid }
  end
end

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
#  corporate              :boolean          default(FALSE)
#  mover_url              :string
#

require 'rails_helper'

# It would be counter-productive to test Devise itself.
# It already has a comprehensive suite of tests that you are able run yourself,
# should you doubt its efficacy.

describe User do

  let(:user) { FactoryGirl.create(:user) }

  it { expect(user).to be_valid }
  it { expect(user).to respond_to(:admin) }
  it { expect(user).to respond_to(:corporate) }
  it { expect(user).to_not be_admin }
  it { expect(user).to_not be_corporate }

  describe "with admin attribute set to 'true'" do
    before do
      user.save!
      user.toggle!(:admin)
    end

    it { expect(user).to be_admin }
  end

  describe "with corporate attribute set to 'true'" do
    before do
      user.save!
      user.toggle!(:corporate)
    end

    it { expect(user).to be_corporate }
  end

  describe "CSV export" do
    before(:all) { FactoryGirl.create(:user) }

    %w(id username sign_in_count created_at confirmed_at updated_at).each do |attr|
      it { expect(User.to_csv).to include(attr) }
    end

    it "returns comma-separated values" do
      User.first.update_columns(username: "Masatoshi Nishiguchi")
      expect(User.to_csv).to match /\w+,Masatoshi Nishiguchi,\w+/
    end
  end
end

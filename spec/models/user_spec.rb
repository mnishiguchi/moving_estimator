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

  let(:user) { FactoryGirl.create(:user) }

  it { expect(user).to be_valid }
  it { expect(user).to respond_to(:admin) }
  it { expect(user).to_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      user.save!
      user.toggle!(:admin)
    end

    it { expect(user).to be_admin }
  end
end

require 'rails_helper'

describe "Users signup", type: :feature do

  subject { page }

  describe "signup page" do
    before { visit "/users/sign_up" }

    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end
end

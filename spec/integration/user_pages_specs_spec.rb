require 'rails_helper'

describe "User pages", type: :feature do

  subject { page }

  describe "signup page" do
    before { visit "/users/sign_up" }

    it { expect(page).to have_content('Sign up') }
    it { expect(page).to have_title(full_title('Sign up')) }
  end
end

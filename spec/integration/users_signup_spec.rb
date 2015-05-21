require 'rails_helper'

describe "Users signup", type: :feature do

  subject { page }

  describe "signup page" do
    before { visit "/users/sign_up" }

    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit "/users/sign_up" }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",              with: "Example User"
        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "password"
        fill_in "Password confirmation", with: "password"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end

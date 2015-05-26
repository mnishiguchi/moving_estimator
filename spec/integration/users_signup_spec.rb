require 'rails_helper'

describe "Users signup", type: :feature do

  describe "signup page" do
    before { visit new_user_registration_path }

    it { expect(page).to have_content('Sign up') }
    it { expect(page).to have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { visit new_user_registration_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { expect(page).to have_title('Sign up') }
        it { expect(page).to have_content('error') }
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

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { expect(page).to have_title(full_title("")) }  # Root page
        it { expect(page).to have_success_message('confirmation link') }
      end
    end
  end
end

require 'rails_helper'

describe "Users login", type: :feature do

  subject { page }

  describe "login page" do
    before { visit new_user_session_path }

    it { is_expected.to have_content('Log in') }
    it { is_expected.to have_title(full_title('Log in')) }
  end

  describe "login" do
    before { visit new_user_session_path }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { is_expected.to have_title('Log in') }
      it { is_expected.to have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "logo" }
        it { should_not have_error_message('Invalid') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_login(user) }

      it { is_expected.to have_title(full_title("Dashboard")) }
      it { is_expected.to_not have_link('Log in', href: new_user_session_path) }

      describe "navbar dropdown links" do
        before { click_link user.username }

        it { is_expected.to have_link("Dashboard", href: root_path) }
        it { is_expected.to have_link("Settings",  href: edit_user_registration_path) }
        it { is_expected.to have_link("Contact",   href: contact_path) }
        it { is_expected.to have_link('Log out',   href: destroy_user_session_path) }
      end

      describe "followed by logout" do
        before do
          click_link user.username
          click_link "Log out"
        end

        it { should have_link('Log in') }
      end
    end
  end
end

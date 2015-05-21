require 'rails_helper'

describe "Users login", type: :feature do

  subject { page }

  describe "login page" do
    before { visit '/users/sign_in' }

    it { is_expected.to have_content('Log in') }
    it { is_expected.to have_title(full_title('Log in')) }
  end

  describe "login" do
    before { visit '/users/sign_in' }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title(full_title("Log in")) }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { click_link "logo" }
        it { should_not have_selector('div.alert.alert-danger') }
      end

      it { is_expected.to have_title('Log in') }
      it { is_expected.to have_selector('div.alert.alert-danger') }
    end

    describe "with valid information" do
      let(:user) do
        FactoryGirl.create(:user)
      end

      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Log in"
      end

      it { is_expected.to have_title(full_title("Dashboard")) }
      it { is_expected.to have_link('Log out',    href: destroy_user_session_path) }
      it { is_expected.to_not have_link('Log in', href: new_user_session_path) }
    end
  end
end

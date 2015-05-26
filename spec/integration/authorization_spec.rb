require 'rails_helper'

describe "authorization", type: :feature do

  describe "for non-logged-in users" do
    let(:user) { FactoryGirl.create(:user) }

    describe "in the Users controller" do

      describe "visiting the edit page" do
        before { visit edit_user_registration_path }
        it { expect(page).to have_title('Log in') }  # Login page
      end

      describe "visiting the user index" do
        pending # this is for admin only
        before { visit users_path }
        it { expect(page).to have_title(full_title("")) }  # Root page
      end
    end

    describe "after signing in" do
      before do
        visit edit_user_registration_path
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
      end

      it "should render the desired protected page" do
        expect(page).to have_title('Edit User')
      end
    end
  end
end

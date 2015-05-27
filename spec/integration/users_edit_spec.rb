require 'rails_helper'

describe "Users edit", type: :feature do

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      log_in_as(user)
      visit edit_user_registration_path
    end

    describe "page" do
      it { expect(page).to have_title("Edit User") }
      it { expect(page).to have_content("Update my account") }
      it { expect(page).to have_content("Cancel my account") }
    end

    describe "with invalid information" do
      before { click_button "Update" }

      it { expect(page).to have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Username",         with: new_name
        fill_in "Email",            with: new_email
        fill_in "Current password", with: user.password
        click_button "Update"
      end

      it { expect(page).to have_link(new_name) }
      it { expect(page).to have_selector('div.alert.alert-success') }
      it { expect(page).to have_link('Log out', href: destroy_user_session_path) }
      specify { expect(user.reload.username).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end

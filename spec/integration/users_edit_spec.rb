require 'rails_helper'

describe "Users edit", type: :feature do

  subject { page }

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_login(user)
      visit edit_user_registration_path
    end

    describe "page" do
      it { is_expected.to have_title("Edit User") }
      it { is_expected.to have_content("Update my account") }
      it { is_expected.to have_content("Cancel my account") }
    end

    describe "with invalid information" do
      before { click_button "Update" }

      it { is_expected.to have_content('error') }
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

      it { should have_link(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Log out', href: destroy_user_session_path) }
      specify { expect(user.reload.username).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end

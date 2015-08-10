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
      before do
        fill_in "Username",         with: ""
        fill_in "Email",            with: "invalid_email..com.@"
        click_button "Update"
      end

      it { expect(page).to have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }

      describe "only username" do
        before do
          fill_in "Username", with: new_name
          click_button "Update"
        end

        # FIXME: fix a bug - new name is not updated after submission

        it { expect(page).to have_success_message "Your account has been updated successfully" }
        it { expect(page).to have_link(new_name) }

        specify { expect(user.reload.username).to eq new_name }
      end

      describe "including new email" do
        before do
          fill_in "Username", with: new_name
          fill_in "Email",    with: new_email
          click_button "Update"
        end

        it { expect(page).to have_success_message "we need to verify your new email address" }
        it { expect(page).to have_link(user.username) }

        specify { expect(user.reload.username).not_to eq new_name }
        specify { expect(user.reload.email).not_to eq new_email }
      end
    end
  end
end

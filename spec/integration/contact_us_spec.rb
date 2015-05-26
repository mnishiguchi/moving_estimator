require 'rails_helper'

describe "Contact us", type: :feature do

  describe "contact page" do
    before { visit contact_path }

    it { expect(page).to have_content('Contact') }
    it { expect(page).to have_title(full_title('Contact')) }
  end

  describe "contact form" do
    before { visit contact_path }

    let(:submit) { "Submit" }

    describe "with invalid information" do
      it { expect(page).to_not send_email_by_click }

      describe "after submission" do
        before { click_button submit }

        it { expect(page).to have_title('Contact') }
        it { expect(page).to have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username", with: "Example User"
        fill_in "Email",    with: "user@example.com"
        fill_in "Message",  with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
      end

      it { expect(page).to send_email_by_click }

      describe "after saving the user" do
        before { click_button submit }

        let(:user) { User.find_by(email: 'user@example.com') }

        it { expect(page).to have_title(full_title("")) }  # Root page
        it { expect(page).to have_info_message('Thank you') }
      end
    end
  end
end

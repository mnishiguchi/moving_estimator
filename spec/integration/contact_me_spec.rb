require 'rails_helper'

describe "Contact me", type: :feature do

  subject { page }

  describe "contact page" do
    before { visit "/contact" }

    it { is_expected.to have_content('Contact') }
    it { is_expected.to have_title(full_title('Contact')) }
  end

  describe "contact form" do
    before { visit "/contact" }

    let(:submit) { "Submit" }

    describe "with invalid information" do
      it { is_expected.to_not send_email_by_click }

      describe "after submission" do
        before { click_button submit }

        it { is_expected.to have_title('Contact') }
        it { is_expected.to have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username", with: "Example User"
        fill_in "Email",    with: "user@example.com"
        fill_in "Message",  with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
      end

      it { is_expected.to send_email_by_click }

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { is_expected.to have_title(full_title("")) }  # Root page
        it { is_expected.to have_info_message('Thank you') }
      end
    end
  end
end

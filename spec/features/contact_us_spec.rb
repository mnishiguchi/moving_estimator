require 'rails_helper'

describe "Contact us", type: :feature do

  describe "contact page" do
    before { visit contact_path }

    it "has correct title and content" do
      expect(page).to have_content('Feedback')
      expect(page).to have_title(full_title('Feedback'))
    end
  end

  describe "contact form" do
    before { visit contact_path }

    let(:submit) { "Send" }

    describe "with invalid information" do
      it { expect(page).to_not send_email_by_click }

      describe "after submission" do
        before { click_button submit }

        it "re-renders the Contact page with error message" do
          expect(page).to have_title('Feedback')
          expect(page).to have_content('error')
        end
      end
    end

    describe "with valid information" do
      before do
        find("#contact_username").set "Example User"
        find("#contact_email").set "user@example.com"
        find("#contact_message").set "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
      end

      it "sends email, then redirects to the root page with thank you message" do
        expect(page).to send_email_by_click
        expect(page).to have_title(full_title(""))  # Root page
        expect(page).to have_info_message('Thank you')
      end
    end
  end
end

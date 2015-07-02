require 'rails_helper'

describe "Static pages", type: :feature do

  let(:base_title) { "MNISHIGUCHI" }

  describe "Home page" do
    before { visit root_path }
    it { expect(page).to have_content(/Moving Estimator/i) }
    it { expect(page).to have_title(full_title("")) }
  end

  describe "About page" do
    before { visit about_path }
    it { expect(page).to have_content(/Masatoshi/i) }
    it { expect(page).to have_title(full_title("About")) }
  end

  describe "Navbar links" do
    it "should have the right links on the layout" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_title(full_title("Sign up"))
      first(:link, "Log in").click
      expect(page).to have_title(full_title("Log in"))
      click_link "Contact"
      expect(page).to have_title(full_title("Contact"))
      click_link "logo"
      expect(page).to have_title(full_title(""))
    end
  end
end

require 'rails_helper'

describe "Static pages", type: :feature do

  subject { page }

  let(:base_title) { "MNISHIGUCHI" }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    it { expect(page).to have_content('Moving Estimator') }
    let(:page_title) { '' }
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    it { expect(page).to have_content(/Masatoshi/i) }
    let(:page_title) { 'About' }
    it_should_behave_like "all static pages"
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

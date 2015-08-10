require 'rails_helper'

feature "OmniAuth interface" do

  before { OmniAuth.config.mock_auth[:twitter] = nil }

  describe "new user or non-logged-in user who is not registered with Twitter" do
    let(:submit) { "Sign up / Log in with Twitter" }

    describe "authentication error" do
      before do
        visit root_path
        expect(page).to have_content(submit)
        set_invalid_omniauth
        click_link(submit)
      end

      it { expect(page).to have_content('Could not authenticate you from Twitter') }
    end

    describe "authentication success" do
      before do
        visit root_path
        expect(page).to have_content(submit)
        set_omniauth
        click_link(submit)
      end

      it "asks user for email address" do
        expect(page).to have_content("need your email address")
      end

      describe "filling out the form" do
        let(:continue) { "Continue" }

        describe "with invalid information" do
          before do
            find("#user_username").set "User Example"
            find("#user_email").set ""
            click_button(continue)
          end

          it { expect(page).to have_content("error") }
        end

        describe "with valid information" do
          before do
            find("#user_username").set "User Example"
            find("#user_email").set "user@example.com"
            click_button(continue)
          end

          it { expect(page).to have_content("sent you a confirmation email") }
        end
      end
    end
  end

  describe "non-logged-in user who is registered with Twitter" do
    let(:submit) { "Sign up / Log in with Twitter" }
    let!(:user) do
      user = FactoryGirl.create(:user)
      user.social_profiles.create(FactoryGirl.attributes_for(:social_profile))
      user.confirm!
      user
    end

    before do
      visit root_path
      expect(page).to have_content(submit)
      set_omniauth
      click_link(submit)
    end

    it "can log in with Twitter" do
      expect(current_path).to eq movings_path
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
    end
  end

  describe "logged-in user who is an omniauth first-timer" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      log_in_as user
      visit root_path
      set_omniauth
    end

    it "not registered with Twitter" do
      expect(find("input#twitter-auth")).not_to be_disabled
      expect(user.social_profile(:twitter)).to be_nil
    end

    describe "clicking on Twitter button" do
      before { find("input#twitter-auth").click }

      it "connects with Twitter" do
        expect(page).to have_content("Successfully authenticated from Twitter account")
        expect(find("input#twitter-auth")).to be_disabled
        expect(user.social_profile(:twitter)).not_to be_nil
      end

      describe "logging out" do
        let(:submit) { "Sign up / Log in with Twitter" }
        before do
          logout :user
          visit root_path
          expect(page).to have_content(submit)
          set_omniauth
          click_link(submit)
        end

        it "can log in with Twitter" do
          expect(current_path).to eq movings_path
          expect(page).to have_content(user.username)
          expect(page).to have_content(user.email)
        end
      end
    end
  end
end

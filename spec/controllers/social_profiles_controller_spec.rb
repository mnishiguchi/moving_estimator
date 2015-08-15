require 'rails_helper'

RSpec.describe SocialProfilesController, type: :controller do

  let!(:user) { create(:user) }
  let!(:profile) { user.social_profiles.create(attributes_for(:social_profile)) }

  describe "non-logged-in user" do
    describe 'DELETE #destroy' do

      it "redirects to the log in page" do
        delete :destroy, id: profile
        expect(response).to redirect_to new_user_session_url
      end

      it "does not delete a social profile" do
        expect{
          delete :destroy, id: profile
        }.to_not change(SocialProfile, :count)
      end
    end
  end

  describe "logged-in user" do
    before { log_in_as user, no_capybara: true }

    describe 'DELETE #destroy' do
      describe "another person's social profile" do
        let!(:random_profile) do
          create(:user).social_profiles.create(attributes_for(:social_profile))
        end

        it "does not delete a social profile" do
          expect{
            delete :destroy, id: random_profile
          }.to_not change(SocialProfile, :count)
        end
      end

      describe "user's own social profile" do
        it "redirects to root page" do
          delete :destroy, id: profile
          expect(response).to redirect_to root_path
        end

        it "deletes a social profile" do
          expect{
            delete :destroy, id: profile
          }.to change(SocialProfile, :count).by(-1)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "non-logged-in user" do

    describe 'GET #index' do
      it "redirects to root page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe 'DELETE #destroy' do
      before { FactoryGirl.create(:user) }  # Creating a user in database.
      let(:user) { User.first }             # Getting one from datatase as needed.

      it "redirects to root page" do
        delete :destroy, id: FactoryGirl.create(:user)
        expect(response).to redirect_to root_path
      end

      it "does not delete a user" do
        expect{
          delete :destroy, id: user.id
        }.to_not change(User,:count)
      end
    end
  end

  describe "logged-in user" do
    before { log_in_as FactoryGirl.create(:user), no_capybara: :true }

    describe 'GET #index' do
      it "redirects to root page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe 'DELETE #destroy' do
      before { @user = FactoryGirl.create(:user) }

      it "redirects to root page" do
        delete :destroy, id: FactoryGirl.create(:user)
        expect(response).to redirect_to root_path
      end
      it "does not delete a user" do
        expect{
          delete :destroy, id: @user
        }.to_not change(User,:count)
      end
    end
  end

  describe "admin user" do
    before { log_in_as FactoryGirl.create(:admin), no_capybara: :true }

    describe 'GET #index' do
      it "renders the index page" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'DELETE #destroy' do
      before { FactoryGirl.create(:user) }  # Creating a user in database.
      let(:user) { User.first }             # Getting one from datatase as needed.

      it "deletes a user" do
        expect{
          delete :destroy, id: user.id
        }.to change(User,:count).by(-1)
      end
    end
  end
end

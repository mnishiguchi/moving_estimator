require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "non-logged-in user" do

    describe 'GET #index' do
      it "redirects to root page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET #show' do
      it "redirects to log in page" do
        get :show
        expect(response).to redirect_to new_user_session_path
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

  describe "logged-in user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
    end

    describe 'GET #index' do
      it "redirects to root page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET #show' do
      it "renders the show page" do
        get :show
        expect(response).to render_template :show
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
    before do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
    end

    describe 'GET #index' do
      it "renders the index page" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it "renders the show page" do
        get :show
        expect(response).to render_template :show
      end
    end

    describe 'DELETE #destroy' do
      before { @user = FactoryGirl.create(:user) }

      it "deletes a user" do
        expect{
          delete :destroy, id: @user
        }.to change(User,:count).by(-1)
      end
    end
  end
end

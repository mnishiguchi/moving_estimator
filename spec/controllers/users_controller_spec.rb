require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "non-logged-in user" do

    describe 'GET #index' do
      it "redirects to root page" do
        get :index
        expect(response).to redirect_to root_path
      end

      describe "CSV format" do
        subject { get :index, format: "csv" }
        it "redirects to root page" do
          get :index, format: "csv"
          expect(response).to redirect_to root_path
        end
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

      describe "CSV format" do
        subject { get :index, format: "csv" }
        it "redirects to root page" do
          get :index, format: "csv"
          expect(response).to redirect_to root_path
        end
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

      describe "CSV format" do
        render_views
        before { get :index, format: "csv" }
        let(:user) { User.first}

        it { expect(response).to render_template :index }
        it { expect(response.headers["Content-Type"]).to eq "text/csv; charset=utf-8" }

        attributes = %w(id username sign_in_count created_at confirmed_at updated_at)
        attributes.each do |field|
          it { expect(response.body).to include user[field].to_s }
        end
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

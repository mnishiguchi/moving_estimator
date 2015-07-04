require 'rails_helper'

RSpec.describe MovingsController, type: :controller do

  let(:user)   { FactoryGirl.create(:user) }  # A current user
  let(:moving_params) { FactoryGirl.attributes_for(:moving) }
  let(:moving) { user.movings.create(moving_params) }

  let(:masa)   { FactoryGirl.create(:user) }  # A random person

  describe "non-logged-in user" do
    describe "#index" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "#new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "#create" do
      it "does not increment the Moving count, redirecting to the login page" do
        expect{
          post :create, moving: moving_params
        }.not_to change(Moving, :count)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "#edit" do
      it "redirects to the login page" do
        get :edit, id: moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "#update" do
      it "redirects to the login page" do
        patch :update, id: moving.id, moving: moving_params
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "#destroy" do
      it "redirects to the login page" do
        delete :destroy, id: moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "logged-in user" do
    before do
      log_in_as user, no_capybara: :true
    end

    let(:random_moving) { masa.movings.create(moving_params) }

    describe "#index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "#new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "#create" do
      it "increments the Moving count, then redirects to the show page" do
        expect{
          post :create, moving: moving_params
        }.to change(Moving, :count).by(1)
        expect(response).to redirect_to(assigns(:moving))
      end
    end

    describe "#edit" do
      describe "for another user's moving" do
        it "redirects to the root page" do
          get :edit, id: random_moving.id
          expect(response).to redirect_to root_url
        end
      end

      describe "for the current user's own moving" do
        it "returns http success" do
          get :edit, id: moving.id
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe "#update" do
      let(:new_title) { "new title" }
      let(:new_description) { "new description" }

      describe "for another user's moving" do
        it "redirects to the root page" do
          patch :update, id: random_moving.id, moving: { title: new_title,
                                                 description: new_description }
          expect(response).to redirect_to root_url
        end
      end

      describe "for the current user's own moving" do
        before do
          patch :update, id: moving, moving: { title:       new_title,
                                               description: new_description }
        end

        it { expect(response).to redirect_to assigns(:moving) }
        specify { expect(moving.reload.title).to eq new_title }
        specify { expect(moving.reload.description).to eq new_description }
      end
    end

    describe "#destroy" do
      let!(:moving) { user.movings.create(moving_params) }
      let!(:random_moving) { masa.movings.create(moving_params) }

      describe "for another user's moving" do
        it "does not decrement the moving count, redirecting to the root page" do
          expect{
            delete :destroy, id: random_moving.id
          }.not_to change(Moving, :count)
          expect(response).to redirect_to root_url
        end
      end

      describe "for the current user's own moving" do
        it "decrements the moving count, then redirects to the movings page" do
          expect{
            delete :destroy, id: moving.id
          }.to change(Moving, :count).by(-1)
          expect(response).to redirect_to movings_url
        end
      end
    end
  end
end

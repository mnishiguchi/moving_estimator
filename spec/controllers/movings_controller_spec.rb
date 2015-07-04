require 'rails_helper'

#     movings GET    /movings(.:format)                movings#index
#             POST   /movings(.:format)                movings#create
#  new_moving GET    /movings/new(.:format)            movings#new
# edit_moving GET    /movings/:id/edit(.:format)       movings#edit
#      moving GET    /movings/:id(.:format)            movings#show
#             PATCH  /movings/:id(.:format)            movings#update
#             PUT    /movings/:id(.:format)            movings#update
#             DELETE /movings/:id(.:format)            movings#destroy

RSpec.describe MovingsController, type: :controller do

  let(:user)   { FactoryGirl.create(:user) }  # A current user
  let(:moving) { user.movings.create(moving_params) }
  let(:moving_params) { FactoryGirl.attributes_for(:moving) }

  let(:masa)   { FactoryGirl.create(:user) }  # A random person

  describe "non-logged-in user" do
    describe "GET #index" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #show" do
      it "redirects to the login page" do
        get :show, id: moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "POST #create" do
      it "does not change the Moving count, redirecting to the login page" do
        expect{
          post :create, moving: moving_params
        }.not_to change(Moving, :count)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #edit" do
      it "redirects to the login page" do
        get :edit, id: moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "PATCH #update" do
      it "redirects to the login page" do
        patch :update, id: moving.id, moving: moving_params
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "DELETE #destroy" do
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

    describe "GET #index" do
      subject { get :index }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template(:index) }
    end

    describe "GET #show" do
      subject { get :show, id: id }

      describe "for another user's moving" do
        let(:id) { random_moving.id }
        it { is_expected.to redirect_to "/" }
      end

      describe "for the current user's own moving" do
        let(:id) { moving.id }
        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template :show }
      end
    end

    describe "GET #new" do
      subject { get :new }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template(:new) }
    end

    describe "POST #create" do
      it "increments the Moving count, then redirects to the show page" do
        expect{
          post :create, moving: moving_params
        }.to change(Moving, :count).by(1)
        expect(response).to redirect_to(assigns(:moving))
      end
    end

    describe "GET #edit" do
      subject { get :edit, id: id }

      describe "for another user's moving" do
        let(:id) { random_moving.id }
        it { is_expected.to redirect_to "/" }
      end

      describe "for the current user's own moving" do
        let(:id) { moving.id }
        it { is_expected.to have_http_status(:success) }
        it { is_expected.to render_template :edit }
      end
    end

    describe "PATCH #update" do
      let(:new_title) { "new title" }
      let(:new_description) { "new description" }

      describe "for another user's moving" do
        before do
          patch :update, id: random_moving, moving: { title:       new_title,
                                               description: new_description }
        end

        it { expect(response).to redirect_to "/" }
        specify { expect(moving.reload.title).not_to eq new_title }
        specify { expect(moving.reload.description).not_to eq new_description }
      end

      describe "for the current user's own moving" do
        before do
          patch :update, id: moving, moving: { title:       new_title,
                                               description: new_description }
        end

        it "redirects to the moving url" do
          expect(response).to redirect_to assigns(:moving)
        end
        specify { expect(moving.reload.title).to eq new_title }
        specify { expect(moving.reload.description).to eq new_description }
      end
    end

    describe "DELETE #destroy" do
      describe "for another user's moving" do
        let!(:random_moving) { masa.movings.create(moving_params) }

        it "does not change the moving count, redirecting to the root url" do
          expect{
            delete :destroy, id: random_moving.id
          }.not_to change(Moving, :count)
          expect(response).to redirect_to "/"
        end
      end

      describe "for the current user's own moving" do
        let!(:moving) { user.movings.create(moving_params) }

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

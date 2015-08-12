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

  let(:user)   { create(:user) }  # A current user
  let(:moving) { user.movings.create(attributes_for(:moving)) }

  let(:masa) { create(:user) }  # A random person

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
      let(:moving_params) { attributes_for(:moving) }

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
      let(:moving_params) { attributes_for(:moving) }

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

    describe "GET #index" do
      subject { get :index }

      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template(:index) }
    end

    describe "GET #show" do
      subject { get :show, id: id }

      let(:random_moving) { masa.movings.create(attributes_for(:moving)) }

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
          params = attributes_for(:moving)
          post :create, moving: params.merge(rooms: ["", "1", "4"])
        }.to change(Moving, :count).by(1)
        expect(response).to redirect_to(assigns(:moving))
      end
    end

    describe "GET #edit" do
      subject { get :edit, id: id }

      let(:random_moving) { masa.movings.create(attributes_for(:moving)) }

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

      let(:random_moving) { masa.movings.create(attributes_for(:moving)) }
      let(:new_params) do
        hash = attributes_for(:moving).merge(rooms: ["", "3", "5"])
        hash[:title] = "new title"
        hash[:description] = "new description"
        hash
      end

      describe "for another user's moving" do

        before { patch :update, id: random_moving, moving: new_params }

        it { expect(response).to redirect_to "/" }
        specify { expect(random_moving.reload.title).not_to eq new_params[:title] }
        specify { expect(random_moving.reload.description).not_to eq new_params[:description] }
      end

      describe "for the current user's own moving" do
        before { patch :update, id: moving, moving: new_params }

        it "redirects to the moving url" do
          expect(response).to redirect_to assigns(:moving)
        end
        specify { expect(moving.reload.title).to eq new_params[:title] }
        specify { expect(moving.reload.description).to eq new_params[:description] }
      end
    end

    describe "DELETE #destroy" do
      describe "for another user's moving" do
        let!(:random_moving) { masa.movings.create(attributes_for(:moving)) }

        it "does not change the moving count, redirecting to the root url" do
          expect{
            delete :destroy, id: random_moving.id
          }.not_to change(Moving, :count)
          expect(response).to redirect_to "/"
        end
      end

      describe "for the current user's own moving" do
        let!(:moving) { user.movings.create(attributes_for(:moving)) }

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

require 'rails_helper'

#     moving_items POST   /moving_items(.:format)           moving_items#create
#  new_moving_item GET    /moving_items/new(.:format)       moving_items#new
# edit_moving_item GET    /moving_items/:id/edit(.:format)  moving_items#edit
#      moving_item PATCH  /moving_items/:id(.:format)       moving_items#update
#                  PUT    /moving_items/:id(.:format)       moving_items#update
#                  DELETE /moving_items/:id(.:format)       moving_items#destroy

RSpec.describe MovingItemsController, type: :controller do

  # A current user
  let(:user) { FactoryGirl.create(:user) }
  let(:moving)             { user.movings.create FactoryGirl.attributes_for(:moving) }
  let(:moving_item)        { moving.moving_items.create(moving_item_params) }
  let(:moving_item_params) { FactoryGirl.attributes_for(:moving_item) }

  # A random person
  let(:masa) { FactoryGirl.create(:user) }
  let(:random_moving_item) do
    m = masa.movings.create(FactoryGirl.attributes_for(:moving))
    m.moving_item.create(moving_item_params)
  end

  describe "non-logged-in user" do

    describe "GET #new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "POST #create" do
      it "does not change the MovingItem count, redirecting to the login page" do
        expect{
          post :create, moving_item: moving_item_params
        }.not_to change(MovingItem, :count)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #edit" do
      it "redirects to the login page" do
        get :edit, id: moving_item.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "PATCH #update" do
      let(:new_params) do
        p = FactoryGirl.attributes_for(:moving_item)
        p[:name] = "new name"
      end

      before do
        patch :update, id: moving_item, moving: new_params
      end

      it { expect(response).to redirect_to "/users/sign_in" }
      specify { expect(moving_item.reload.attributes).not_to eq new_params }
    end

    describe "DELETE #destroy" do
      it "does not change the moving item count, redirecting to the login page" do
        moving_item  # Create a moving item based on the let(:moving_item) block
        expect{
          delete :destroy, id: moving_item.id
        }.not_to change(MovingItem, :count)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "logged-in user" do
    before do
      log_in_as user, no_capybara: :true
    end

    describe "without selecting a moving" do

      describe "GET #new" do
        it "redirects to the root url" do
          get :new
          expect(response).to redirect_to "/"
        end
      end

      describe "POST #create" do
        it "does not change the MovingItem count, redirecting to the root url" do
          expect{
            post :create, moving_item: moving_item_params
          }.not_to change(MovingItem, :count)
          expect(response).to redirect_to "/"
        end
      end

      describe "GET #edit" do
        it "redirects to the root url" do
          get :edit, id: moving_item.id
          expect(response).to redirect_to "/"
        end
      end

      describe "PATCH #update" do
        let(:new_params) do
          p = FactoryGirl.attributes_for(:moving_item)
          p[:name] = "new name"
        end

        describe "trying to edit another user's moving item" do
          before do
            patch :update, id: moving_item, moving: new_params
          end

          it { expect(response).to redirect_to "/" }
          specify { expect(moving_item.reload.attributes).not_to eq new_params }
        end
      end

      describe "DELETE #destroy" do
        it "does not change the moving item count, redirecting to the root url" do
          moving_item  # Create a moving item based on the let(:moving_item) block
          expect{
            delete :destroy, id: moving_item.id
          }.not_to change(MovingItem, :count)
          expect(response).to redirect_to "/"
        end
      end
    end

    xdescribe "after selecting a moving" do
      xdescribe "another user's item" do

      end

      xdescribe "current user's own item" do

      end
    end
  end
end

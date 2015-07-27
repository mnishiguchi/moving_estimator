require 'rails_helper'

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
    m.moving_items.create(moving_item_params)
  end

  describe "non-logged-in user" do

    describe "POST #create" do

      it "does not change the MovingItem count, redirecting to the login page" do
        expect{
          post :create, moving_item: moving_item_params
        }.not_to change(MovingItem, :count)

        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "PATCH #update" do
      let(:new_name) { "new name" }

      before { patch :update, id: moving_item, moving: { name: new_name } }

      it { expect(response).to redirect_to "/users/sign_in" }

      specify { expect(moving_item.reload.name).not_to eq new_name }
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

      describe "POST #create" do

        it "does not change the MovingItem count, redirecting to the root url" do
          expect{
            post :create, moving_item: moving_item_params
          }.not_to change(MovingItem, :count)

          expect(response).to redirect_to "/"
        end
      end

      describe "PATCH #update" do
        let(:new_name) { "new name" }
        before { patch :update, id: moving_item, moving: new_name }

        it { expect(response).to redirect_to "/" }
        specify { expect(moving_item.reload.attributes).not_to eq new_name }
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

    describe "after selecting a moving" do
      before { remember_moving(moving) }

      describe "POST #create" do

        it "increments the MovingItem count, then redirects to the movings/show page" do
          expect{
            post :create, moving_item: moving_item_params
          }.to change(MovingItem, :count).by(1)
        end
      end

      describe "PATCH #update" do
        let(:new_name) { "new name" }
        let(:new_description) { "new description" }

        describe "for another user's moving item" do
          before do
            patch :update, id: random_moving_item,
                  moving_item: { name: new_name, description: new_description }
          end

          it { expect(response).to redirect_to "/" }

          specify { expect(moving_item.reload.name).not_to eq new_name }
          specify { expect(moving_item.reload.description).not_to eq new_description }
        end

        describe "for the current user's own moving" do
          before do
            patch :update, id: moving_item, moving_item: { name: new_name,
                                                 description: new_description }
          end

          it { expect(response).to have_http_status(:success) }

          specify { expect(moving_item.reload.name).to eq new_name }
          specify { expect(moving_item.reload.description).to eq new_description }
        end
      end

      describe "DELETE #destroy" do
        describe "for another user's moving item" do

          it "does not change the MovingItem count, redirecting to the root url" do
            random_moving_item
            expect{
              delete :destroy, id: random_moving_item.id
            }.not_to change(MovingItem, :count)

            expect(response).to redirect_to "/"
          end
        end

        describe "for the current user's own moving" do
          it "decrements the MovingItem count" do
            moving_item
            expect{
              delete :destroy, id: moving_item.id
            }.to change(MovingItem, :count).by(-1)

            expect(response).to have_http_status(:success)
          end
        end
      end
    end
  end
end

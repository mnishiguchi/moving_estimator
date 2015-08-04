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

    describe 'GET #index' do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end

      describe "CSV format" do
        before { get :index, format: "csv" }
        it { expect(response.status).to eq 401 }
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

      describe 'GET #index' do
        it "redirects to the root url" do
          get :index
          expect(response).to redirect_to "/"
        end

        describe "CSV format" do
          before { get :index, format: "csv" }
          it { expect(response).to redirect_to "/" }
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
      before do
        remember_moving(moving)

        10.times do
          attributes = FactoryGirl.attributes_for(:moving_item)
          moving.moving_items.create(attributes)
        end
      end

      describe 'GET #index' do
        describe "CSV format" do
          render_views

          before { get :index, format: "csv" }

          it { expect(response).to render_template :index }
          it { expect(response.headers["Content-Type"]).to eq "text/csv; charset=utf-8" }

          describe "head" do
            it { expect(response.body).to include Time.zone.now.getlocal.to_s[0..9] }
            it { expect(response.body).to include moving.title }
            it { expect(response.body).to include moving.description }
          end

          describe "body" do
            attributes = %w(name volume quantity room category description)

            attributes.each do |field|
              it "has column name - #{field}" do
                expect(response.body).to include field
              end
            end

            attributes.each do |field|
              it "has correct value for #{field}" do
                expect(response.body).to include moving_item[field].to_s
              end
            end

            it "has correct number of rows" do
              num_of_rows = 5 + moving.moving_items.count
              expect(response.body.split(/\n/).size).to eq num_of_rows
            end
          end
        end
      end

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

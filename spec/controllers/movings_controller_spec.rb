require 'rails_helper'

RSpec.describe MovingsController, type: :controller do

  let!(:user)   { FactoryGirl.create(:user) }
  let!(:moving) { FactoryGirl.create(:moving) }

  before do
    log_in_as user, no_capybara: :true
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "creating a moving" do
    it "increments the Moving count, then redirects to the show page" do
      expect{
        post :create, moving: { user_id:     user.id,
                                title:       "title",
                                description: "description" }
      }.to change(Moving, :count).by(1)
      expect(response).to redirect_to(assigns(:moving))
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: moving
      expect(response).to have_http_status(:success)
    end
  end

  describe "updating a moving, then redirects" do
    let(:new_title) { "New tittle" }
    let(:new_description) { "New descripion" }
    before do
      patch :update, id: moving,
        moving: { title: new_title, description: new_description}
    end

    it { expect(response).to have_http_status(:redirect) }
    specify { expect(moving.reload.title).to eq new_title }
    specify { expect(moving.reload.description).to eq new_description }
  end

  describe "destroying a moving" do
    let!(:moving) do
      FactoryGirl.create(:moving)  # Creating a moving in database.
      Moving.first                 # Getting one from datatase.
    end

    it "decrements the moving count, then redirects" do
      expect{
        delete :destroy, id: moving.id
      }.to change(Moving, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end

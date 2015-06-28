require 'rails_helper'

RSpec.describe MovingsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

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
                                description: "description",
                                categories:  ["ocean", "air"],
                                rooms:       ["kitchen", "living"] }
      }.to change(Moving, :count).by(1)
      expect(response).to redirect_to(assigns(:moving))
    end
  end

  describe "editing a moving" do
    pending
  end

  describe "updating a moving" do
    pending
  end

  describe "destroying a moving" do
    pending
  end

end

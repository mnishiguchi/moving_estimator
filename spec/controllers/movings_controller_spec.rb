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
                                description: "description" }
      }.to change(Moving, :count).by(1)
      expect(response).to redirect_to(assigns(:moving))
    end
  end

  xdescribe "editing a moving" do

  end

  xdescribe "updating a moving" do

  end

  xdescribe "destroying a moving" do

  end

end

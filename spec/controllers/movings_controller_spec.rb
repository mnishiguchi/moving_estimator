require 'rails_helper'

# See example
# https://github.com/mhartl/sample_app_4_0_upgrade/blob/master/spec/controllers/relationships_controller_spec.rb
# https://www.relishapp.com/rspec/rspec-rails/v/2-4/docs/matchers/redirect-to-matcher

RSpec.describe MovingsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:moving) { FactoryGirl.create(:moving) }

  before { log_in_as user, no_capybara: :true }

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

    it "should increment the Moving count" do
      expect{
        post :create, moving: { user_id: user.id,
                                title: "title",
                                description: "description",
                                categories: %w[ocean air],
                                rooms: %w[kitchen living] }
      }.to change(Moving, :count).by(1)
    end

    it "redirects to show after successful creation"
    # expect(response).to have_http_status(:success)
  end

  describe "GET #edit" do
    # it "returns http success" do
    #   get :edit
    #   expect(response).to have_http_status(:success)
    # end
  end

  describe "GET #update" do
    # it "returns http success" do
    #   get :update
    #   expect(response).to have_http_status(:success)
    # end
  end

  describe "GET #destroy" do
    # it "returns http success" do
    #   get :destroy
    #   expect(response).to have_http_status(:success)
    # end
  end

end

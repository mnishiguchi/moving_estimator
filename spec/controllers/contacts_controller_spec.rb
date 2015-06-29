require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "creating a message" do
    it "redirects to root path" do
      post :create, contact: { username: "Example User",
                               email:    "user@example.com",
                               message:  "Hello world!" }
      expect(response).to redirect_to root_path
    end
  end

end

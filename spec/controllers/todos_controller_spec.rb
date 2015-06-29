require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  before { log_in_as FactoryGirl.create(:user), no_capybara: :true }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "creating a todo with Ajax" do
    it "increments the Todo count, then returns http success" do
      expect{
        xhr :post, :create, todo: { content: "Practice RSpec" }
      }.to change(Todo, :count).by(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe "updating a todo with Ajax" do
    # Maybe integration test is better for this.
    pending
  end

  describe "destroying a todo with Ajax" do
    before { FactoryGirl.create(:todo) }  # Creating a todo in database.
    let(:todo) { Todo.first }             # Getting one from datatase as needed.

    it "decrements the todo count, then returns http success" do
      expect{
        xhr :delete, :destroy, id: todo.id
      }.to change(Todo, :count).by(-1)
      expect(response).to have_http_status(:success)
    end
  end
end

require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before { log_in_as user, no_capybara: :true }

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "creating a todo with Ajax" do

    it "should increment the todo count" do
      expect do
        xhr :post, :create, todo: { content: "Read Rails documentation" }
      end.to change(Todo, :count).by(1)
    end

    it "returns http success" do
      xhr :post, :create, todo: { content: "Practice Ruby" }
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

    before { FactoryGirl.create(:todo) }

    let(:todo) { Todo.first }

    it "should decrement the todo count" do
      expect{
        xhr :delete, :destroy, id: todo.id
      }.to change(Todo, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: todo.id
      expect(response).to have_http_status(:success)
    end
  end

end

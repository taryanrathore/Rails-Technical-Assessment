require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let!(:other_users) { create_list(:user, 3) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /users" do
    it "returns a successful response and displays all users in descending order" do
      get users_path
      expect(response).to have_http_status(:ok)

      ordered_users = User.order(id: :desc).pluck(:id)
      response_ids = assigns(:users).pluck(:id)
      expect(response_ids).to eq(ordered_users)
    end
  end

  describe "GET /users/:id" do
    it "returns a successful response and displays the user" do
      get user_path(user)
      expect(response).to have_http_status(:ok)
      expect(assigns(:user)).to eq(user)
    end
  end
end

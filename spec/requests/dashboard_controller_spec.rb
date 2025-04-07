require 'rails_helper'

RSpec.describe DashboardController, type: :request do
  let(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:announcement) { create(:announcement) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /" do
    it "returns a successful response and assigns courses and announcements" do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:courses)).to include(course)
      expect(assigns(:announcements)).to include(announcement)
    end
  end

  describe "POST /add_to_favorite" do
    context "when course is not already in favorites" do
      it "adds the course to user's favorites" do
        expect {
          post add_to_favorite_dashboard_index_path, params: { course_id: course.id }
        }.to change { user.reload.favorites.count }.by(0)
      end
    end

    context "when course is already in favorites" do
      before { user.favorites.create(course_id: course.id) }

      it "removes the course from favorites" do
        expect {
          post add_to_favorite_dashboard_index_path, params: { course_id: course.id }
        }.to change { user.reload.favorites.count }.by(0)

      end
    end

    context "when an invalid course_id is passed" do
      it "does not raise an error and redirects to root" do
        expect {
          post add_to_favorite_dashboard_index_path, params: { course_id: 0 }
        }.not_to raise_error
      end
    end
  end
end

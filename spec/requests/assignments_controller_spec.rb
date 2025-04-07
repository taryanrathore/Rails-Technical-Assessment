require 'rails_helper'

RSpec.describe AssignmentsController, type: :request do
  let(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:assignment) { create(:assignment, course: course) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /assignments" do
    it "renders the index page" do
      get assignments_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(assignment.title)
    end
  end

  describe "GET /assignments/:id" do
    it "renders the show page" do
      get assignment_path(assignment)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /assignments/new" do
    it "renders the new assignment form" do
      get new_assignment_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /assignments" do
    it "creates a new assignment" do
      expect {
        post assignments_path, params: {
          assignment: {
            title: "New Assignment",
            description: "Something interesting",
            course_id: course.id
          }
        }
      }.to change(Assignment, :count).by(1)

      expect(response).to redirect_to(Assignment.last)
    end
  end

  describe "GET /assignments/:id/edit" do
    it "renders the edit form" do
      get edit_assignment_path(assignment)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /assignments/:id" do
    it "updates the assignment" do
      patch assignment_path(assignment), params: {
        assignment: { title: "Updated Title" }
      }
      expect(response).to redirect_to(assignment)
      expect(assignment.reload.title).to eq("Updated Title")
    end
  end

  describe "DELETE /assignments/:id" do
    it "deletes the assignment" do
      expect {
        delete assignment_path(assignment)
      }.to change(Assignment, :count).by(-1)

      expect(response).to redirect_to(assignments_path)
    end
  end
end

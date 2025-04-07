require 'rails_helper'

RSpec.describe "CoursesController", type: :request do
  let(:user) { create(:user) }
  let!(:term) { create(:term) }
  let!(:course) { create(:course, term: term) }
  
  before do
    login_as(user, scope: :user)
  end

  describe "GET /courses" do
    it "renders the index page" do
      get courses_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(course.title)
    end
  end

  describe "GET /courses/:id" do
    it "renders the show page" do
      get course_path(course)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(course.title)
    end
  end

  describe "GET /courses/new" do
    it "renders the new course form" do
      get new_course_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Course")
    end
  end

  describe "POST /courses" do
    context "with valid parameters" do
      it "creates a course and redirects" do
        expect {
          post courses_path, params: {
            course: {
              title: "New Course",
              term_id: term.id,
              status: "active"
            }
          }
        }.to change(Course, :count).by(1)
        expect(response).to redirect_to(course_path(Course.last))
      end
    end

    context "with invalid parameters" do
      it "re-renders the new template" do
        post courses_path, params: { course: { title: "", term_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /courses/:id/edit" do
    it "renders the edit form" do
      get edit_course_path(course)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Course")
    end
  end

  describe "PATCH /courses/:id" do
    context "with valid parameters" do
      it "updates the course and redirects" do
        patch course_path(course), params: {
          course: { title: "Updated Title" }
        }
        expect(response).to redirect_to(course_path(course))
        follow_redirect!
        expect(response.body).to include("Updated Title")
      end
    end

    context "with invalid parameters" do
      it "re-renders the edit template" do
        patch course_path(course), params: {
          course: { title: "" }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /courses/:id" do
    it "deletes the course and redirects to index" do
      expect {
        delete course_path(course)
      }.to change(Course, :count).by(-1)
      expect(response).to redirect_to(courses_path)
    end
  end
end

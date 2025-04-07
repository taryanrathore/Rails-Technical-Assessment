require 'rails_helper'

RSpec.describe TermsController, type: :request do
  let(:user) { create(:user) }
  let!(:term) { create(:term) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /terms" do
    it "returns a successful response" do
      get terms_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(term.name)
    end
  end

  describe "GET /terms/:id" do
    it "shows the term" do
      get term_path(term)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(term.name)
    end
  end

  describe "GET /terms/new" do
    it "renders the new form" do
      get new_term_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /terms" do
    context "with valid parameters" do
      it "creates a new term and redirects" do
        expect {
          post terms_path, params: { term: { name: "Spring 2025" } }
        }.to change(Term, :count).by(1)
        expect(response).to redirect_to(Term.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new term and re-renders form" do
        expect {
          post terms_path, params: { term: { name: "" } }
        }.not_to change(Term, :count)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /terms/:id/edit" do
    it "renders the edit form" do
      get edit_term_path(term)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /terms/:id" do
    context "with valid parameters" do
      it "updates the term and redirects" do
        patch term_path(term), params: { term: { name: "Updated Term" } }
        expect(response).to redirect_to(term)
        term.reload
        expect(term.name).to eq("Updated Term")
      end
    end

    context "with invalid parameters" do
      it "does not update the term and re-renders form" do
        patch term_path(term), params: { term: { name: "" } }
        expect(response).to have_http_status(:ok)
        term.reload
        expect(term.name).not_to eq("")
      end
    end
  end

  describe "DELETE /terms/:id" do
    it "deletes the term and redirects to index" do
      expect {
        delete term_path(term)
      }.to change(Term, :count).by(-1)
      expect(response).to redirect_to(terms_path)
    end
  end
end

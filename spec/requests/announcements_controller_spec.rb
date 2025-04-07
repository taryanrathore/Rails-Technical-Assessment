require 'rails_helper'

RSpec.describe AnnouncementsController, type: :request do
  include Warden::Test::Helpers

  let(:user) { create(:user) }
  let!(:announcement) { create(:announcement) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /announcements' do
    it 'renders the index template' do
      get announcements_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /announcements/:id' do
    it 'shows the announcement' do
      get announcement_path(announcement)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(announcement.title)
    end
  end

  describe 'GET /announcements/new' do
    it 'renders the new template' do
      get new_announcement_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /announcements' do
    let(:valid_params) { { announcement: { title: 'New', content: 'Details' } } }

    it 'creates a new announcement and broadcasts' do
      allow(ActionCable.server).to receive(:broadcast)

      expect {
        post announcements_path, params: valid_params
      }.to change(Announcement, :count).by(1)

      expect(response).to redirect_to(announcements_path)
      expect(ActionCable.server).to have_received(:broadcast).at_least(:once)
    end

    it 're-renders the form on failure' do
      post announcements_path, params: { announcement: { title: '', content: '' } }
      expect(response.body).to include('error')
    end
  end

  describe 'GET /announcements/:id/edit' do
    it 'renders the edit form' do
      get edit_announcement_path(announcement)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH /announcements/:id' do
    it 'updates the announcement and redirects' do
      patch announcement_path(announcement), params: { announcement: { title: 'Updated' } }
      expect(response).to redirect_to(announcement_path(announcement))
    end

    it 're-renders edit on failure' do
      patch announcement_path(announcement), params: { announcement: { title: '' } }
      expect(response.body).to include('error')
    end
  end

  describe 'DELETE /announcements/:id' do
    it 'deletes the announcement' do
      expect {
        delete announcement_path(announcement)
      }.to change(Announcement, :count).by(-1)
    end
  end
end

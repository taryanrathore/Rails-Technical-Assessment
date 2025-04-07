class DashboardController < ApplicationController
  def index
    @courses = Course.all
    @announcements = Announcement.all
  end

  def add_to_favorite
    fav = current_user.favorites.find_by(course_id: params[:course_id])
    if fav.present?
      fav.destroy
    else
      current_user.favorites.create(course_id: params[:course_id])
    end
    redirect_to root_path
  end 
end
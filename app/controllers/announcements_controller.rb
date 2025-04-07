class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[show edit update destroy]

  def index
    @courses = Course.all
    @announcements = Announcement.all  
  end


  def show; end

  def new
    @announcement = Announcement.new
  end

 def create
   @announcement = Announcement.new(announcement_params)
   if @announcement.save
     broadcast_notification(@announcement)
     redirect_to announcements_path, notice: 'Announcement created successfully.'
   else
     render :new
   end
 end


  def edit; end

  def update
    if @announcement.update(announcement_params)
      redirect_to @announcement, notice: 'Announcement updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    redirect_to announcements_path, notice: 'Announcement deleted successfully.'
  end

  private

  def broadcast_notification(announcement)
    User.find_each do |user|
      ActionCable.server.broadcast(
        "notifications_#{user.id}",
        {
          title: announcement.title,
          content: announcement.content,
          created_at: announcement.created_at.strftime('%Y-%m-%d %H:%M')
        }
      )
    end
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :content, :image)
  end
end
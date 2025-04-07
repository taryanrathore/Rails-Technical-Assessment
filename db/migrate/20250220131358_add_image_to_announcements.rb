class AddImageToAnnouncements < ActiveRecord::Migration[8.0]
  def change
    add_column :announcements, :image, :string
  end
end

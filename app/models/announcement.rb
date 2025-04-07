class Announcement < ApplicationRecord
  validates :title, :content, presence: true
  has_one_attached :image

  validates :title, :content, presence: true
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :favorites, dependent: :destroy
  has_one_attached :avatar

  enum :role, {student: 0, instructor: 1, admin: 2}
  validates :role, presence: true
end

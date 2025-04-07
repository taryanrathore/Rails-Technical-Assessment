class Course < ApplicationRecord
  belongs_to :term
  has_many :assignments, dependent: :destroy

  validates :title, :status, :term_id, presence: true
  enum :status, {active: 0, closed: 1}

  before_create :generate_course_code

  private
  def generate_course_code
    self.code = "IT-#{rand(100..999)}-OLA#{rand(1..5)}"
  end
end

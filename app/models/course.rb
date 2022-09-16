class Course < ApplicationRecord
  validates :name, presence: true

  has_many :course_teacher
  has_many :teachers, through: :course_teachers
  has_many :assessments
end

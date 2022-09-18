class Course < ApplicationRecord
  validates :name, presence: true

  has_many :enrolments, dependent: :destroy
  has_many :students, through: :enrolments

  has_many :course_teacher
  has_many :teachers, through: :course_teachers
end

class Enrolment < ApplicationRecord
  belongs_to :course
  belongs_to :student

  validates :student_id, uniqueness: {scope: :course_id,
                                      message: "already enrolled!"}
end

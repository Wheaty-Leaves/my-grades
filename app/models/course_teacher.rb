# This model exists to link the many to many relationship
# between teachers and courses
class CourseTeacher < ApplicationRecord
    # validates :teacher_id, presence: true
    # validates :course_id, presence: true
    belongs_to :teacher
    belongs_to :course
end

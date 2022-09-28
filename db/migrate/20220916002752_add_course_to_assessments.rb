class AddCourseToAssessments < ActiveRecord::Migration[7.0]
  def change
    add_column :assessments, :course_id, :int
  end
end

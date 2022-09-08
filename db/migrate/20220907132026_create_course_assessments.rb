class CreateCourseAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :course_assessments do |t|
      t.has_many :assessment
      t.belongs_to :course
      t.timestamps
    end
  end
end

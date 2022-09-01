class CreateCourseTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :course_teachers do |t|
      t.belongs_to :teacher
      t.belongs_to :course
      t.timestamps
    end
  end
end

class AddColumnsToAssessments < ActiveRecord::Migration[7.0]
  def change
    add_column :assessments, :canvas_id, :int
    add_column :assessments, :canvas_course_id, :int
  end
end

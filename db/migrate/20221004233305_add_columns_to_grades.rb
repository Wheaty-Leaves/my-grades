class AddColumnsToGrades < ActiveRecord::Migration[7.0]
  def change
    add_column :grades, :canvas_student_id, :int
    add_column :grades, :canvas_id, :int
    add_column :grades, :canvas_assignment_id, :int
  end
end

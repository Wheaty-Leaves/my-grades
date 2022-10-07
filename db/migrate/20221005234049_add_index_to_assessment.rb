class AddIndexToAssessment < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :last_canvas_request, :datetime
    add_column :teachers, :last_canvas_request, :datetime

  end
end

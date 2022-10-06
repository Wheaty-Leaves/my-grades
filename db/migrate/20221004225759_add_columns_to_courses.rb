class AddColumnsToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :canvas_id, :int
    add_column :courses, :enrollment_term_id, :int
    add_column :courses, :uuid, :string
  end
end

class AddColumnToGradesGradedAt < ActiveRecord::Migration[7.0]
  def change
    add_column :grades, :graded_at, :string
  end
end

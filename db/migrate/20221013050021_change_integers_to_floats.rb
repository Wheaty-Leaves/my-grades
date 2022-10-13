class ChangeIntegersToFloats < ActiveRecord::Migration[7.0]
  def change
    change_column :assessments, :max_score, :float
    change_column :grades, :score, :float
  end
end

class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :assessments do |t|
      t.string :name
      t.int :total
      t.date :due_date
      t.date :release_date

      t.timestamps
    end
  end
end

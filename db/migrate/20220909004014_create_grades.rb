class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.belongs_to :student
      t.belongs_to :assessment
      t.integer :score
      t.timestamps
    end
  end
end

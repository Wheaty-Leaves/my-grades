class AddColumnsToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :access_token, :string
  end
end

json.extract! assessment, :id, :name, :total, :due_date, :release_date, :created_at, :updated_at
json.url assessment_url(assessment, format: :json)

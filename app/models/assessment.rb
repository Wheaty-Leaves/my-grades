class Assessment < ApplicationRecord
  belongs_to :courses
  has_many :grades
end

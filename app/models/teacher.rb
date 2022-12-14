class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :uniID, presence: true, uniqueness: true
  validates :email, uniqueness: true
  
  has_many :course_teacher
  has_many :courses, through: :course_teachers

end

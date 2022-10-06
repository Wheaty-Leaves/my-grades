class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :enrolments
  has_many :courses, through: :enrolments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :uniID, presence: true, uniqueness: true
  validates :email, uniqueness: true
  validates :access_token, presence: true, uniqueness: true
  has_many :grades
end

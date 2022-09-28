require 'rails_helper'

RSpec.describe Enrolment, type: :model do
  course = Course.new(
    name: "Engineering Software as a Service")

  it "is valid with valid attributes" do
    student = build(:student)
    student.save
    course.save
    subject = Enrolment.new(
      course_id: course.id,
      student_id: student.id
    )
    expect(subject).to be_valid
  end

  it "is not valid without a course" do
    student = build(:student)
    student.save
    course.save
    subject = Enrolment.new(
      course_id: course.id,
      student_id: student.id
    )
    subject.course_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a student" do
    student = build(:student)
    student.save
    course.save
    subject = Enrolment.new(
      course_id: course.id,
      student_id: student.id
    )
    subject.student_id = nil
    expect(subject).to_not be_valid
  end
end

require 'rails_helper'

RSpec.describe CourseTeacher, :type => :model do
  teacher = Teacher.new(
    email: "a1776887@adelaide.edu.au",
    password: "Password123",
    first_name: "Max",
    last_name: "School",
    uniID: "a1776887")

  course = Course.new(
    name: "Engineering Software as a Service")

  it "is valid with valid attributes" do
    course.save
    teacher.save
    subject = CourseTeacher.new(
      teacher_id: teacher.id,
      course_id: course.id)

    expect(subject).to be_valid
  end

  it "is not valid when course is not in database" do
    teacher.save
    subject = CourseTeacher.new(
      teacher_id: teacher.id,
      course_id: course.id)
    expect(subject).to_not be_valid
  end

  it "is not valid when teacher is not in database" do
    course.save
    subject = CourseTeacher.new(
      teacher_id: teacher.id,
      course_id: course.id)

    expect(subject).to_not be_valid
  end

  it "is not valid without a course" do
    course.save
    teacher.save
    subject = CourseTeacher.new(
      teacher_id: teacher.id,
      course_id: course.id)

    subject.teacher_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a teacher" do
    course.save
    teacher.save
    subject = CourseTeacher.new(
      teacher_id: teacher.id,
      course_id: course.id)

    subject.course_id = nil
    expect(subject).to_not be_valid
  end
end
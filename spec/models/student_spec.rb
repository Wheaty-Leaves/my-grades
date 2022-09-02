require 'rails_helper'

RSpec.describe Student, type: :model do
  context "validations" do
    it "ensures that first name is not null" do
      student = build(:student)
      student.first_name = ""
      student.validate
      expect(student.errors[:first_name]).to include("can't be blank")
    end

    it "ensures that last name is not null" do
      student = build(:student)
      student.last_name = ""
      student.validate
      expect(student.errors[:last_name]).to include("can't be blank")
    end

    it "ensures that uni ID is not null" do
      student = build(:student)
      student.uniID = ""
      student.validate
      expect(student.errors[:uniID]).to include("can't be blank")
    end

    it "ensures that email is not null" do
      student = build(:student)
      student.email = ""
      student.validate
      expect(student.errors[:email]).to include("can't be blank")
    end

    it "ensures that password is not null" do
      student = build(:student)
      student.password = ""
      student.validate
      expect(student.errors[:password]).to include("can't be blank")
    end
  end
end

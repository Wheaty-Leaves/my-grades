require 'rails_helper'

RSpec.describe Teacher, type: :model do

  subject{
    build(:teacher)
  }

  context "validations" do
    it "ensures that first name is not null" do
      subject.first_name = ""
      subject.validate
      expect(subject.errors[:first_name]).to include("can't be blank")
    end

    it "ensures that last name is not null" do
      subject.last_name = ""
      subject.validate
      expect(subject.errors[:last_name]).to include("can't be blank")
    end

    it "ensures that uni ID is not null" do
      subject.uniID = ""
      subject.validate
      expect(subject.errors[:uniID]).to include("can't be blank")
    end

    it "ensures that email is not null" do
      subject.email = ""
      subject.validate
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it "ensures that password is not null" do
      subject.password = ""
      subject.validate
      expect(subject.errors[:password]).to include("can't be blank")
    end
  end
end

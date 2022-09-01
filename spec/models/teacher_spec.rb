require 'rails_helper'

RSpec.describe Teacher, type: :model do
  subject {
    described_class.new(
      email: "a1766887@adelaide.edu.au",
      password: "Password123",
      first_name: "Max",
      last_name: "School",
      uniID: "a1766887")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end

require 'rails_helper'

RSpec.describe Course, :type => :model do
    subject {
        described_class.new(
            name: "Engineering Software as a Service")
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without a title" do
        subject.name = nil
        expect(subject).to_not be_valid
    end
end
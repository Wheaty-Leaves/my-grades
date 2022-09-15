require 'rails_helper'

RSpec.describe "enrolments/show", type: :view do
  before(:each) do
    assign(:enrolment, Enrolment.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

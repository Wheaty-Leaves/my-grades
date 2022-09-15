require 'rails_helper'

RSpec.describe "enrolments/new", type: :view do
  before(:each) do
    assign(:enrolment, Enrolment.new())
  end

  it "renders new enrolment form" do
    render

    assert_select "form[action=?][method=?]", enrolments_path, "post" do
    end
  end
end

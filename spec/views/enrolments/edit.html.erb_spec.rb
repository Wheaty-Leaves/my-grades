require 'rails_helper'

RSpec.describe "enrolments/edit", type: :view do
  let(:enrolment) {
    Enrolment.create!()
  }

  before(:each) do
    assign(:enrolment, enrolment)
  end

  it "renders the edit enrolment form" do
    render

    assert_select "form[action=?][method=?]", enrolment_path(enrolment), "post" do
    end
  end
end

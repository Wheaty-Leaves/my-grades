require 'rails_helper'

RSpec.describe "assessments/edit", type: :view do
  let(:assessment) {
    Assessment.create!(
      name: "MyString",
      total: 1
    )
  }

  before(:each) do
    assign(:assessment, assessment)
  end

  it "renders the edit assessment form" do
    render

    assert_select "form[action=?][method=?]", assessment_path(assessment), "post" do

      assert_select "input[name=?]", "assessment[name]"

      assert_select "input[name=?]", "assessment[total]"
    end
  end
end

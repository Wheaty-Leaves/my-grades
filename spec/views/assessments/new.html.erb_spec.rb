require 'rails_helper'

RSpec.describe "assessments/new", type: :view do
  before(:each) do
    assign(:assessment, Assessment.new(
      name: "MyString",
      total: 1
    ))
  end

  it "renders new assessment form" do
    render

    assert_select "form[action=?][method=?]", assessments_path, "post" do

      assert_select "input[name=?]", "assessment[name]"

      assert_select "input[name=?]", "assessment[total]"
    end
  end
end

require 'rails_helper'

RSpec.describe "assessments/show", type: :view do
  before(:each) do
    assign(:assessment, Assessment.create!(
      name: "Name",
      total: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end

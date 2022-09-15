require 'rails_helper'

RSpec.describe "enrolments/index", type: :view do
  before(:each) do
    assign(:enrolments, [
      Enrolment.create!(),
      Enrolment.create!()
    ])
  end

  it "renders a list of enrolments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end

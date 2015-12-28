require 'rails_helper'

RSpec.describe "records/index", type: :view do
  before(:each) do
    assign(:records, [
      Record.create!(
        :name => "Name"
      ),
      Record.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of records" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

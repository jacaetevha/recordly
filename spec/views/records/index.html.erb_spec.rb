require 'rails_helper'

RSpec.describe "records/index", type: :view do
  let(:user) { new_user }
  before(:each) do
    Record.create!(title: "Name", user_id: user.id)
    Record.create!(title: "Name", user_id: user.id)
    _records = Record.all.page(1)
    _records.each {|e| e.current_user = user}
    assign(:records, _records)
  end

  it "renders a list of records" do
    render
    assert_select ".record-short", count: 2
  end
end

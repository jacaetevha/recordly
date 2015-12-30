require 'rails_helper'

RSpec.describe "records/new", type: :view do
  let(:user) { new_user }
  before(:each) do
    assign(:record, Record.new(title: "MyString", user_id: user.id)).tap do |r|
      r.current_user = user
    end
  end

  it "renders new record form" do
    render
    assert_select "form[action=?][method=?]", records_path, "post" do
      assert_select "input#record_title[name=?]", "record[title]"
    end
  end
end

require 'rails_helper'

RSpec.describe "records/edit", type: :view do
  let(:user) { new_user }
  before(:each) do
    @record = assign(:record, Record.create!(title: "MyString", user_id: user.id)).tap do |r|
      r.current_user = user
    end
  end

  it "renders the edit record form" do
    render
    assert_select "form[action=?][method=?]", record_path(@record), "post" do
      assert_select "input#record_title[name=?]", "record[title]"
    end
  end
end

require 'rails_helper'

RSpec.describe "records/show", type: :view do
  let(:user) { new_user }
  before(:each) do
    @record = assign(:record, Record.create!(title: "Name", user_id: user.id)).tap do |r|
      r.current_user = user
    end
  end

  it "should not be favorited" do
    render
    assert_select ".single-record-details h3" do
      assert_select "a[href=?]", favorite_record_path(@record) do
        assert_select "span.text-muted"
      end
    end
  end
end

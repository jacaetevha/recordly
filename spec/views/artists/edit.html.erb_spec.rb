require 'rails_helper'

RSpec.describe "artists/edit", type: :view do
  let(:user) { new_user }
  before(:each) do
    @artist = assign(:artist, Artist.create!(name: "MyString")).tap do |a|
      a.current_user = user
    end
  end

  it "renders the edit artist form" do
    render
    assert_select "form[action=?][method=?]", artist_path(@artist), "post" do
      assert_select "input#artist_name[name=?]", "artist[name]"
    end
  end
end

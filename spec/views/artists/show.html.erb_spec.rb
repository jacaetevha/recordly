require 'rails_helper'

RSpec.describe "artists/show", type: :view do
  let(:user) { new_user }
  before(:each) do
    @artist = assign(:artist, Artist.create!(name: "Name")).tap do |a|
      a.current_user = user
    end
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

require 'rails_helper'

RSpec.describe "artists/index", type: :view do
  let(:user) { new_user }
  before(:each) do
    Artist.create!(name: "Name")
    Artist.create!(name: "Name")
  end
  before(:each) do
    _artists = Artist.all.page(1)
    _artists.each {|e| e.current_user = user}
    assign(:artists, _artists)
  end

  it "renders a list of artists" do
    render
    actual_response = JSON response
    expect(actual_response["total"]).to eq 2
    expect(actual_response["count"]).to eq 2
    expect(actual_response["page"]).to eq 1
    expect(actual_response["artists"].count).to eq 2
  end
end

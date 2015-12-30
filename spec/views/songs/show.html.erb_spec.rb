require 'rails_helper'

RSpec.describe "songs/show", type: :view do
  let(:user) { new_user }
  let(:artist) do
    Artist.create(name: 'artist').tap { |a| a.current_user = user }
  end
  let(:record) do
    assign(:record, Record.create(title: 'record', artist_ids: [artist.id], user_id: user.id)).tap do |r|
      r.current_user = user
    end
  end
  before(:each) do
    @song = assign(:song, Song.create!(title: "my great title", record_id: record.id)).tap do |s|
      s.current_user = user
    end
  end

  it "renders the song title" do
    render
    expect(rendered).to match(/Title:/)
    expect(rendered).to match(/#{@song.title}/)
  end

  it "renders the record header widget" do
    render
    assert_select "table.table.record-short" do
      assert_select "td.image" do
        assert_select "div.record.img-circle"
      end
      assert_select "td.link" do
        assert_select "a[href=?]", record_path(record)
      end
    end
  end
end

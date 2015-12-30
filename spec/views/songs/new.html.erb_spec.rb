require 'rails_helper'

RSpec.describe "songs/new", type: :view do
  let(:user) { new_user }
  let(:artist) { Artist.create name: 'artist' }
  let(:record) { Record.create title: 'record', artist_ids: [artist.id], user_id: user.id }
  before(:each) do
    @song = assign(:song, Song.new(title: "my great title", record_id: record.id))
  end

  it "renders the new song form" do
    render
    assert_select "form[action=?][method=?]", record_songs_path(record), "post" do
      assert_select "input#song_title[name=?]", "song[title]"
      assert_select "input#song_ordinal[name=?]", "song[ordinal]"
      assert_select "input#song_record_id[name=?][type=hidden]", "song[record_id]"
    end
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

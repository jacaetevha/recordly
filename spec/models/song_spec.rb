require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:user) { new_user }
  let(:artist) { Artist.create name: 'artist' }
  let(:record) { Record.create title: 'record', artist_ids: [artist.id], user_id: user.id }
  let(:s1) { Song.create record_id: record.id, ordinal: 1, title: 'one' }

  describe :update do
    it "should not allow the record's user to be changed" do
      s1.update record_id: record.id + 1
      expect(s1.errors[:record_id]).to eq ['Change of record_id not allowed!']
    end
  end

  describe '#reorder' do
    def check_ordinals(songs)
      songs.each do |song, ordinal|
        song.reload
        expect(song.ordinal).to eq ordinal
      end
    end

    let(:s2) { Song.create record_id: record.id, ordinal: 2, title: 'two' }
    let(:s3) { Song.create record_id: record.id, ordinal: 3, title: 'three' }

    before :each do
      # make sure each song is created before running specs
      [s1, s2, s3]
    end

    context 'adding a new song to the end' do
      it 'should not reorder anything' do
        s = Song.create record_id: record.id, ordinal: 4, title: 'four'
        check_ordinals s1 => 1, s2 => 2, s3 => 3, s => 4
      end
    end

    context 'adding a new song to the beginning' do
      it 'should reorder everything' do
        s = Song.create record_id: record.id, ordinal: 1, title: 'four'
        check_ordinals s => 1, s1 => 2, s2 => 3, s3 => 4
      end
    end

    context 'adding a new song to the middle' do
      it 'should insert the new song, and then reorder things after it' do
        s = Song.create record_id: record.id, ordinal: 2, title: 'four'
        check_ordinals s1 => 1, s => 2, s2 => 3, s3 => 4
      end
    end
  end
end

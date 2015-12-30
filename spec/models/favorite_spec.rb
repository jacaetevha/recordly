require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { User.create! name: 'foo', email: 'foo@example.com', password: 'password', password_confirmation: 'password' }

  describe "artists" do
    let(:a_favorite_artist) { Artist.create(name: 'fav artist').tap {|a| a.toggle_favorite!(user)} }
    let(:not_a_favorite_artist) { Artist.create name: 'not fav artist' }

    before :each do
      # make sure the artists are created
      a_favorite_artist
      not_a_favorite_artist
    end

    it 'should update the artist as a favorite' do
      expect(not_a_favorite_artist.favorite?(user)).to be false
      expect{not_a_favorite_artist.toggle_favorite!(user)}.to change{favorite_artist_count}.from(1).to(2)
      not_a_favorite_artist.reload
      expect(not_a_favorite_artist.favorite?(user)).to be true
    end

    it 'should update the artist as a non-favorite' do
      expect(a_favorite_artist.favorite?(user)).to be true
      expect{a_favorite_artist.toggle_favorite!(user)}.to change{favorite_artist_count}.from(1).to(0)
      a_favorite_artist.reload
      expect(a_favorite_artist.favorite?(user)).to be false
    end
  end

  describe "favoriting a record" do
    let(:a_favorite_record) { Record.create(title: 'foobar').tap {|r| r.toggle_favorite!(user)} }
    let(:not_a_favorite_record) { Record.create title: 'foobar' }

    before :each do
      # make sure the records are created
      a_favorite_record
      not_a_favorite_record
    end

    context 'records' do
      it 'should update the record as a favorite' do
        expect(not_a_favorite_record.favorite?(user)).to be false
        expect{not_a_favorite_record.toggle_favorite!(user)}.to change{favorite_record_count}.from(1).to(2)
        not_a_favorite_record.reload
        expect(not_a_favorite_record.favorite?(user)).to be true
      end

      it 'should update the record as a non-favorite' do
        expect(a_favorite_record.favorite?(user)).to be true
        expect{a_favorite_record.toggle_favorite!(user)}.to change{favorite_record_count}.from(1).to(0)
        a_favorite_record.reload
        expect(a_favorite_record.favorite?(user)).to be false
      end
    end

    context 'songs' do
      let(:songs) do
        (0..3).map do |n|
          s = Song.create title: "song#{n}", record_id: a_favorite_record.id
          if n % 2 == 0
            s.toggle_favorite!(user)
          end
          s
        end
      end

      it 'should update the song as a favorite' do
        expect(songs[1].favorite?(user)).to be false
        expect{songs[1].toggle_favorite!(user)}.to change{favorite_song.count}.from(2).to(3)
        songs[1].reload
        expect(songs[1].favorite?(user)).to be true
      end

      it 'should update the song as a non-favorite' do
        expect(songs[0].favorite?(user)).to be true
        expect{songs[0].toggle_favorite!(user)}.to change{favorite_song.count}.from(2).to(1)
        songs[0].reload
        expect(songs[0].favorite?(user)).to be false
      end
    end
  end

  def favorite_artist
    Favorite.where(model_class: 'Artist', user_id: user.id)
  end

  def favorite_artist_count
    favorite_artist.count
  end

  def favorite_record
    Favorite.where(model_class: 'Record', user_id: user.id)
  end

  def favorite_record_count
    favorite_record.count
  end

  def favorite_song
    Favorite.where(model_class: 'Song', user_id: user.id)
  end

  def favorite_song_count
    favorite_song.count
  end
end

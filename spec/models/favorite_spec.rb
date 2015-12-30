require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { new_user }

  describe "artists" do
    let(:a_favorite_artist) { Artist.create(name: 'fav artist').tap {|a| set_current_user(a).toggle_favorite!} }
    let(:not_a_favorite_artist) { Artist.create name: 'not fav artist' }

    before :each do
      # make sure the artists are created
      set_current_user a_favorite_artist
      set_current_user not_a_favorite_artist
    end

    it 'should update the artist as a favorite' do
      expect(not_a_favorite_artist.favorite?).to be false
      expect{not_a_favorite_artist.toggle_favorite!}.to change{favorite_artist_count}.from(1).to(2)
      not_a_favorite_artist.reload
      expect(not_a_favorite_artist.favorite?).to be true
    end

    it 'should update the artist as a non-favorite' do
      expect(a_favorite_artist.favorite?).to be true
      expect{a_favorite_artist.toggle_favorite!}.to change{favorite_artist_count}.from(1).to(0)
      a_favorite_artist.reload
      expect(a_favorite_artist.favorite?).to be false
    end
  end

  describe "favoriting a record" do
    let(:a_favorite_record) do
      Record.create(title: 'foobar', user_id: user.id).tap {|r| set_current_user(r).toggle_favorite!}
    end
    let(:not_a_favorite_record) { Record.create title: 'foobar', user_id: user.id }

    before :each do
      # make sure the records are created
      set_current_user a_favorite_record
      set_current_user not_a_favorite_record
    end

    context 'records' do
      it 'should update the record as a favorite' do
        expect(not_a_favorite_record.favorite?).to be false
        expect{not_a_favorite_record.toggle_favorite!}.to change{favorite_record_count}.from(1).to(2)
        not_a_favorite_record.reload
        expect(not_a_favorite_record.favorite?).to be true
      end

      it 'should update the record as a non-favorite' do
        expect(a_favorite_record.favorite?).to be true
        expect{a_favorite_record.toggle_favorite!}.to change{favorite_record_count}.from(1).to(0)
        a_favorite_record.reload
        expect(a_favorite_record.favorite?).to be false
      end
    end

    context 'songs' do
      let(:songs) do
        4.times.map do |n|
          s = set_current_user(Song.create(title: "song#{n}", record_id: a_favorite_record.id))
          if n % 2 == 0
            s.toggle_favorite!
          end
          s
        end
      end

      it 'should update the song as a favorite' do
        expect(songs[1].favorite?).to be false
        expect{songs[1].toggle_favorite!}.to change{favorite_song.count}.from(2).to(3)
        songs[1].reload
        expect(songs[1].favorite?).to be true
      end

      it 'should update the song as a non-favorite' do
        expect(songs[0].favorite?).to be true
        expect{songs[0].toggle_favorite!}.to change{favorite_song.count}.from(2).to(1)
        songs[0].reload
        expect(songs[0].favorite?).to be false
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

  def set_current_user(model)
    model.current_user = user
    model
  end
end

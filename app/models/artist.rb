class Artist < ActiveRecord::Base
  include MarkAsFavorite

  has_and_belongs_to_many :records
  has_many :songs, through: :records

  validates :name, presence: true, length: { minimum: 1 }

  def songs_by_record
    songs.map.with_object(Hash.new { |hash, key| hash[key] = [] }) do |song, hash|
      hash[song.record] << song
    end
  end
end

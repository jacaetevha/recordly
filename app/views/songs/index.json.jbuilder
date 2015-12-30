json.array!(@songs) do |song|
  json.extract! song, :id, :name
  json.url record_song_url(song.record, song, format: :json)
end

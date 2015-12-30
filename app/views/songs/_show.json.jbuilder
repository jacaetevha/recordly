json.extract! song, :id, :title, :ordinal, :created_at, :updated_at
json.link record_song_path(song.record, song)

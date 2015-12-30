json.extract! record, :id, :title, :created_at, :updated_at
json.favorite record.favorite?
json.link record_path(record)

if defined?(include_songs) && include_songs
  json.songs(record.songs) do |song|
    json.partial! 'songs/show', locals: { song: song }
  end
end

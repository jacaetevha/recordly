json.partial! 'show', locals: {song: @song}
json.record do
  json.link record_path(@song.record)
end

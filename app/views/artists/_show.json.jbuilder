json.extract! artist, :id, :name, :created_at, :updated_at
json.link artist_path(artist)
json.favorite artist.favorite?(current_user)
json.records artist.records do |record|
  json.partial! 'records/show', locals: { record: record }
end

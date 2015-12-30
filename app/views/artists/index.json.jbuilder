json.total @artists.total_count
json.count @artists.count
json.page @artists.current_page

json.artists @artists do |artist|
  json.partial! 'show', locals: { artist: artist }
end

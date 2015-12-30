json.total @records.total_count
json.count @records.count
json.page @records.current_page

json.records @records do |record|
  json.extract! record, :id, :title, :created_at, :updated_at
  json.favorite record.favorite?
  json.link record_path(record)
end

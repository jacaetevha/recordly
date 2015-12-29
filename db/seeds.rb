# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

artists = [
  Artist.create!(name: 'Foo'),
  Artist.create!(name: 'Bar'),
  Artist.create!(name: 'Baz'),
  Artist.create!(name: 'Blat')
].map.with_object({}) do |artist, hash|
  hash[artist.name.downcase] = artist
end

songs = [
  ["One", "Two", "Three"],
  ["The first", "A Second", "Some Third Song"],
  ["El numero uno", "Le nom de deux", "Drei"],
  ["nothing better", "except this one", "but not this one"]
]

record_titles = {
  "foo"  => "The songs",
  "bar"  => "A song and more",
  "baz"  => "An epic set",
  "blat" => "Come and get it!"
}
artists.keys.each_with_index do |artist_name, index|
  r = Record.create! title: record_titles[artist_name]
  r.artists = [artists[artist_name]]
  r.songs = songs[index].map.with_index do |e, i|
    Song.create!(title: e, record_id: r.id, ordinal: i+1)
  end
  r.save!
end

["johndoe", "jane doe"].each do |name|
  email = "#{name.gsub(' ', '')}@example.com"
  password = "password"
  u = User.new(name: name, email: email, password: password, password_confirmation: password)
  u.save!
end

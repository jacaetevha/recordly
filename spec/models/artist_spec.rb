require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist1) { Artist.create name: 'artist1' }
  let(:artist2) { Artist.create name: 'artist2' }
  let(:record1) { Record.create title: 'record1', artist_ids: [artist1.id] }
  let(:record2) { Record.create title: 'record2', artist_ids: [artist1.id] }
  let(:record3) { Record.create title: 'record3', artist_ids: [artist2.id] }
  let(:record4) { Record.create title: 'record3', artist_ids: [artist1.id, artist2.id] }
  let(:songs1) { (1..5).map{|e| Song.create!(title: "my great title#{e}", record_id: record1.id) } }
  let(:songs2) { (1..5).map{|e| Song.create!(title: "my great title#{e}", record_id: record2.id) } }
  let(:songs3) { (1..3).map{|e| Song.create!(title: "my great title#{e}", record_id: record3.id) } }
  let(:songs4) { (1..2).map{|e| Song.create!(title: "my great title#{e}", record_id: record4.id) } }

  it 'lists songs by record' do
    #
  end
end

class CreateJoinTableRecordSongs < ActiveRecord::Migration
  def change
    create_join_table :records, :songs do |t|
      t.index :record_id
      t.index :song_id
    end
  end
end

class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.integer :ordinal, null: false
      t.integer :record_id, null: false

      t.timestamps null: false
    end
  end
end

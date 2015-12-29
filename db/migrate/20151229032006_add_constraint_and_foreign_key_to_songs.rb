class AddConstraintAndForeignKeyToSongs < ActiveRecord::Migration
  def change
    add_foreign_key :songs, :records
    reversible do |dir|
      dir.up do
        # add a CHECK constraint
        execute <<-SQL
          ALTER TABLE songs
            ADD CONSTRAINT song_record_chk
              UNIQUE (title, record_id);
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE songs
            DROP CONSTRAINT song_record_chk
        SQL
      end
    end
  end
end

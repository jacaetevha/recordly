class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :model_class
      t.integer :model_id

      t.timestamps null: false
    end
    reversible do |dir|
      dir.up do
        # add a CHECK constraint
        execute <<-SQL
          ALTER TABLE favorites
            ADD CONSTRAINT model_uniqueness_cnstr
              UNIQUE (model_class, model_id);
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE favorites
            DROP CONSTRAINT model_uniqueness_cnstr
        SQL
      end
    end
  end
end

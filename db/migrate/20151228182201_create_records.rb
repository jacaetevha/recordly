class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :title, null: false
      t.string :ordinal_letter, null: false

      t.timestamps null: false
    end
  end
end

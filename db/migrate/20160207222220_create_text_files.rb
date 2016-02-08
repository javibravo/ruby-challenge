class CreateTextFiles < ActiveRecord::Migration
  def change
    create_table :text_files do |t|
      t.string :name
      t.string :original_name
      t.integer :total_words
      t.integer :distinct_words
      t.text :words
      t.datetime :created_at

      t.timestamps null: false
    end
    add_index :text_files, :name, :unique => true
  end
end

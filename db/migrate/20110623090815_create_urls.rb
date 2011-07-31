class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :url
      t.string :title

      t.timestamps
    end
    add_index :urls, :url, :unique => true
  end
end

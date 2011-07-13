class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.text :url
      t.string :title

      t.timestamps
    end
    add_index :urls, :url, :unique => true
  end

  def self.down
    drop_table :urls
  end
end

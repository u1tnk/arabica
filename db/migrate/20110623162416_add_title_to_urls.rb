class AddTitleToUrls < ActiveRecord::Migration
  def self.up
    add_column :urls, :title, :string
  end

  def self.down
    remove_column :urls, :title
  end
end

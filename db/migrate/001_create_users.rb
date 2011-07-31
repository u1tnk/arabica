class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :null => false
      t.string :uid, :null => false
      t.string :screen_name, :null => false
      t.string :name, :null => false
      t.string :profile_image_url, :null => false
      t.string :access_token, :null => false
      t.string :access_secret, :null => false

      t.timestamps
    end
    add_index :users, [:provider, :uid], :unique => true
    add_index :users, [:provider, :screen_name], :unique => true
  end
end

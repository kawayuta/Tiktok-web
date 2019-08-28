class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :user_official_id
      t.text :user_nick_name
      t.text :user_signature
      t.text :user_covers
      t.text :user_following_count
      t.text :user_fans_count
      t.text :user_heart_count
      t.text :user_video_count
      t.boolean :user_verified
      t.text :user_region
      t.text :user_url

      t.timestamps
    end

    add_index :users, :user_official_id, :unique => true, type: :fulltext
    add_index :users, :user_nick_name, type: :fulltext
    add_index :users, :user_signature, type: :fulltext
    add_index :users, :user_covers, :unique => true, type: :fulltext
    add_index :users, :user_following_count, type: :fulltext
    add_index :users, :user_fans_count, type: :fulltext
    add_index :users, :user_heart_count, type: :fulltext
    add_index :users, :user_video_count, type: :fulltext
    add_index :users, :user_verified
    add_index :users, :user_region, type: :fulltext
    add_index :users, :user_url, :unique => true, type: :fulltext

  end
end

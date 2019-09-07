class CreateUserHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_histories do |t|
      t.text :user_official_id, unique: true
      t.text :user_unique_id, unique: true
      t.text :user_sec_id, unique: true
      t.text :user_nick_name
      t.text :user_signature
      t.text :user_covers
      t.text :user_following_count
      t.text :user_fans_count
      t.text :user_heart_count
      t.text :user_video_count
      t.boolean :user_verified
      t.text :user_region
      t.text :user_url, unique: true

      t.timestamps
    end

    add_index :user_histories, :user_official_id, :unique => true, type: :fulltext
    add_index :user_histories, :user_nick_name, type: :fulltext
    add_index :user_histories, :user_signature, type: :fulltext
    add_index :user_histories, :user_covers, :unique => true, type: :fulltext
    add_index :user_histories, :user_following_count, type: :fulltext
    add_index :user_histories, :user_fans_count, type: :fulltext
    add_index :user_histories, :user_heart_count, type: :fulltext
    add_index :user_histories, :user_video_count, type: :fulltext
    add_index :user_histories, :user_verified
    add_index :user_histories, :user_region, type: :fulltext
    add_index :user_histories, :user_url, :unique => true, type: :fulltext

  end
end

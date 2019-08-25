class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :user_official_id
      t.text :user_nick_name
      t.text :user_signature
      t.text :user_covers
      t.decimal :user_following_count
      t.decimal :user_fans_count
      t.decimal :user_heart_count
      t.decimal :user_video_count
      t.boolean :user_verified
      t.text :user_region
      t.text :user_url

      t.timestamps
    end
  end
end

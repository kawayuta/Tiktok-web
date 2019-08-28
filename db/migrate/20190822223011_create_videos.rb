class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.references :user
      t.text :video_url
      t.text :video_official_id
      t.text :video_title
      t.text :video_tags, array: true
      t.text :video_tags_official_ids, array: true
      t.text :video_comment_count
      t.text :video_share_count
      t.text :video_interaction_count
      t.text :video_cover_image
      t.boolean :video_trending

      t.timestamps
    end

    add_index :videos, :video_official_id, :unique => true, type: :fulltext
    add_index :videos, :video_title, type: :fulltext
    add_index :videos, :video_tags, type: :fulltext
    add_index :videos, :video_tags_official_ids, type: :fulltext
    add_index :videos, :video_comment_count, type: :fulltext
    add_index :videos, :video_share_count, type: :fulltext
    add_index :videos, :video_interaction_count, type: :fulltext
    add_index :videos, :video_cover_image, :unique => true, type: :fulltext
    add_index :videos, :video_trending
  end
end

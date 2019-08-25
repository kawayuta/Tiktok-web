class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.references :user
      t.text :video_source
      t.text :video_official_id
      t.text :video_title
      t.text :video_tags, array: true
      t.text :video_comment_count
      t.text :video_play_count
      t.text :video_share_count
      t.text :video_cover_image
      t.text :video_url
      t.boolean :video_trending

      t.timestamps
    end
  end
end

class CreateTagHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_histories do |t|
      t.text :tag_official_id
      t.text :tag_title
      t.text :tag_text
      t.text :tag_cover_image
      t.text :tag_posts_count
      t.text :tag_views_count
      t.text :tag_url
      t.boolean :tag_trending

      t.timestamps
    end


    add_index :tag_histories, :tag_official_id, :unique => true, type: :fulltext
    add_index :tag_histories, :tag_title, type: :fulltext
    add_index :tag_histories, :tag_text, type: :fulltext
    add_index :tag_histories, :tag_cover_image, type: :fulltext
    add_index :tag_histories, :tag_posts_count, type: :fulltext
    add_index :tag_histories, :tag_views_count, type: :fulltext
    add_index :tag_histories, :tag_url, :unique => true, type: :fulltext
    add_index :tag_histories, :tag_trending
  end
end

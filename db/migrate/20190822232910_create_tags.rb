class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.text :tag_official_id, unique: true
      t.text :tag_title, unique: true
      t.text :tag_text
      t.text :tag_cover_image
      t.text :tag_posts_count
      t.text :tag_views_count
      t.text :tag_url
      t.boolean :tag_trending

      t.timestamps
    end


    add_index :tags, :tag_official_id, :unique => true, type: :fulltext
    add_index :tags, :tag_title, type: :fulltext
    add_index :tags, :tag_text, type: :fulltext
    add_index :tags, :tag_cover_image, type: :fulltext
    add_index :tags, :tag_posts_count, type: :fulltext
    add_index :tags, :tag_views_count, type: :fulltext
    add_index :tags, :tag_url, :unique => true, type: :fulltext
    add_index :tags, :tag_trending
  end
end

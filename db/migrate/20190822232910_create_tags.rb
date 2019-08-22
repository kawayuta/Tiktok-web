class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.text :tag_official_id
      t.text :tag_title
      t.text :tag_text
      t.text :tag_cover_image
      t.integer :tag_posts_count
      t.integer :tag_views_count
      t.text :tag_url

      t.timestamps
    end
  end
end

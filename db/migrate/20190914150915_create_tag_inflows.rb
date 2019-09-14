class CreateTagInflows < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_inflows do |t|
      t.references :tag
      t.boolean :youtube

      t.timestamps
    end
  end
end

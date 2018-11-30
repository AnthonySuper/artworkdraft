class CreateArtworkTags < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_tags do |t|
      t.references :artwork, null: false
      t.references :tag, type: :uuid, null: false
      t.timestamps
    end

    add_foreign_key :artwork_tags, :artworks, on_delete: :cascade
    add_foreign_key :artwork_tags, :tags, on_delete: :cascade 
  end
end

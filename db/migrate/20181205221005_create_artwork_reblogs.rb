class CreateArtworkReblogs < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_reblogs do |t|
      t.references :user, index: true, null: false
      t.references :artwork, index: false, null: true
      t.ltree :path, null: false, default: ""
      t.text :comment, null: false, default: ""

      t.timestamps
    end

    add_foreign_key :artwork_reblogs, :users, on_delete: :cascade
    add_foreign_key :artwork_reblogs, :artworks, on_delete: :nullify
  end
end

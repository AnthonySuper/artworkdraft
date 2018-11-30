class CreateArtworkComments < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_comments do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false
      t.text :body, null: false 
      t.references :artwork, foreign_key: { on_delete: :cascade }, null: false
      t.timestamps
    end
  end
end

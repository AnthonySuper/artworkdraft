class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.text :name, null: false
      t.text :description, null: false, default: ""
      t.boolean :nsfw, null: false, default: false 
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end

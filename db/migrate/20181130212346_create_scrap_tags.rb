class CreateScrapTags < ActiveRecord::Migration[5.2]
  def change
    create_table :scrap_tags do |t|
      t.references :scrap, null: false
      t.references :tag, type: :uuid, null: false
      t.timestamps
    end

    add_foreign_key :scrap_tags, :tags, on_delete: :cascade
    add_foreign_key :scrap_tags, :scraps, on_delete: :cascade 
  end
end

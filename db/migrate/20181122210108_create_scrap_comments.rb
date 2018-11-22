class CreateScrapComments < ActiveRecord::Migration[5.2]
  def change
    create_table :scrap_comments do |t|
      t.bigint :user_id, null: false
      t.text :body, null: false
      t.bigint :scrap_id, null: false

      t.timestamps
    end

    add_foreign_key :scrap_comments, :users, on_delete: :cascade
    add_foreign_key :scrap_comments, :scraps, on_delete: :cascade
  end
end

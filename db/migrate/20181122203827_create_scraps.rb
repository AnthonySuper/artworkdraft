class CreateScraps < ActiveRecord::Migration[5.2]
  def change
    create_table :scraps do |t|
      t.references :user, foreign_key: {on_delete: :cascade}
      t.text :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.boolean :nsfw, null: false, default: false 
      t.timestamps
    end
  end
end

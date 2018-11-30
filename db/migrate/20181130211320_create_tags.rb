class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false, default: ""
      t.timestamps
    end
  end
end

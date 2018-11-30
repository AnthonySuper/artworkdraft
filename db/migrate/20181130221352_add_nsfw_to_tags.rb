class AddNsfwToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :nsfw, :boolean, null: false, default: false 
  end
end

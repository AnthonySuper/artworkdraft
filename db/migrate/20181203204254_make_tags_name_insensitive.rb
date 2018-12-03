class MakeTagsNameInsensitive < ActiveRecord::Migration[5.2]
  def change
    change_column :tags, :name, :citext, null: false
  end
end

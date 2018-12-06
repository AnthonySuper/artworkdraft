class AddIndicesToArtworkReblogPaths < ActiveRecord::Migration[5.2]
  def change
    add_index :artwork_reblogs, :path, unique: true
    add_index :artwork_reblogs, :path, using: :gist,
      name: :artwork_reblogs_path_gin
  end
end

class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.references :follower, index: true
      t.references :followee, index: true
      t.timestamps
    end

    add_foreign_key :followings, :users,
      column: :follower_id,
      on_delete: :cascade
    add_foreign_key :followings, :users,
      column: :followee_id,
      on_delete: :cascade
    add_index :followings,
      [:follower_id, :followee_id],
      unique: true 
  end
end

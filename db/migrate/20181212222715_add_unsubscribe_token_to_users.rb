class AddUnsubscribeTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unsubscribe_token, :text
    add_index :users, :unsubscribe_token, unique: true
  end
end

class AddConfirmationStuffToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirmation_token, :text,
      null: true
    add_column :users, :email_confirmed, :boolean,
      null: false, default: false
    add_index :users, :email_confirmation_token, unique: true
  end
end

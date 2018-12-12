class AddNotificationPrefsToUsers < ActiveRecord::Migration[5.2]
  def change
    default_prefs = {
      user_followed: true,
      user_commented: true,
      user_reblogged: true,
    }
    add_column :users, :notification_email_prefs, :jsonb,
      null: false, default: default_prefs
  end
end

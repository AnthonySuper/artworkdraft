class ChangePrefersToPrefs < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :prefers, :prefs
  end
end

class MakeScrapsUserNonNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :scraps, :user_id, false
  end
end

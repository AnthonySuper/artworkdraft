class MakeFollowingsAllNonNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :followings, :follower_id, false
    change_column_null :followings, :followee_id, false
  end
end

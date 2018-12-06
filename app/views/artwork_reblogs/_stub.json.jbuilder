json.extract! artwork_reblog,
  :id,
  :comment,
  :created_at,
  :updated_at
json.user artwork_reblog.user, partial: "users/user", as: :user

json.extract! comment,
  :id,
  :body,
  :created_at,
  :updated_at

json.user comment.user, partial: "users/user", as: :user

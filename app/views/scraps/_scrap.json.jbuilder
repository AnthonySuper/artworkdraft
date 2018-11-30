json.extract! scrap,
  :id,
  :name,
  :description,
  :created_at,
  :updated_at
json.user scrap.user, partial: "users/user", as: :user

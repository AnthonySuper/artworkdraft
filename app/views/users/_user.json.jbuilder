json.extract! user,
  :name,
  :bio,
  :created_at,
  :updated_at,
  :id
json.avatar image_url(user.avatar_img)

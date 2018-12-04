json.extract! user,
  :name,
  :bio,
  :created_at,
  :updated_at,
  :id
json.avatar (user.avatar_img.is_a?(String) ? image_url(user.avatar_img) : url_for(user.avatar_img))

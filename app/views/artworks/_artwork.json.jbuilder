json.extract! artwork,
  :name,
  :description,
  :created_at,
  :updated_at, 
  :id
json.user artwork.user, partial: "users/user", as: :user
json.image_url url_for(artwork.image.variant(resize: "2000x2000>"))

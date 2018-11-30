json.extract! artwork,
  :name,
  :description,
  :created_at,
  :updated_at, 
  :id
json.user artwork.user, partial: "users/user", as: :user

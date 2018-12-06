json.extract! artwork_reblog,
  :id,
  :comment,
  :created_at,
  :updated_at
json.user artwork_reblog.user, partial: "users/user", as: :user
json.ancestors artwork_reblog.ordered_ancestors
  .preload(user: {avatar_attachment: :blob}),
  partial: "artwork_reblogs/stub",
  as: :artwork_reblog
json.root_artwork artwork_reblog.root_artwork, 
  partial: "artworks/artwork", 
  as: :artwork

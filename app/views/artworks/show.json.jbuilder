json.partial! @artwork, partial: "artwork", as: :artwork
json.comments @artwork.comments, partial: "comments/comment", as: :comment

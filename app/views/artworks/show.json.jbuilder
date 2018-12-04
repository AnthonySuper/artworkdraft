json.partial! @artwork, partial: "artwork", as: :artwork
json.comments @artwork.comments, partial: "comments/comment", as: :comment
json.tags @artwork.tags, partial: "tags/tag", as: :tag

json.partial! "scrap", scrap: @scrap
json.comments @scrap.comments, partial: "comments/comment", as: :comment
json.tags @scrap.tags, partial: "tags/tag", as: :tag

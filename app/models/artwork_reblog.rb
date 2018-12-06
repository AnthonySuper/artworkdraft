class ArtworkReblog < ApplicationRecord
  include Feeded

  belongs_to :user
  belongs_to :artwork, required: false

  validates :path, presence: true

  attr_accessor :ancestor_id

  before_validation :create_path
  
  # SCOPES
  def self.for_artworks artworks
    joins(%{
      INNER JOIN artwork_reblogs root 
          ON root.path = subpath(artwork_reblogs.path, 0, 2) })
      .joins("INNER JOIN artworks ON artworks.id = root.id")
      .where("artworks.id" => artworks)
  end

  def self.made_by users
    where(user: users)
  end

  def root_artwork
    return artwork if artwork
    Artwork.find(path.split(".").first)
  end

  def ordered_ancestors
    ArtworkReblog.where("path @> ?", path)
      .order(:path)
      .all
  end

  def immediate_children
    ArtworkReblog.where("path ~ ?", "#{path}.*{1}")
  end

  def next_path
    n = immediate_children.count.to_s
    "#{path}.#{n}"
  end

  private

  def create_path
    if artwork.present? then
      part_1 = artwork.id.to_s
      part_2 = (ArtworkReblog.where(artwork: artwork).count).to_s
      self.path = "#{part_1}.#{part_2}"
    else
      self.path = ArtworkReblog.find(ancestor_id).next_path
    end
  end
end

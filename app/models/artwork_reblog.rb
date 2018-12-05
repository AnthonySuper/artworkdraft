class ArtworkReblog < ApplicationRecord
  belongs_to :user
  belongs_to :artwork, required: false

  validates :path, presence: true

  attr_accessor :ancestor_id

  before_validation :create_path
  
  # SCOPES
  def self.for_artworks artworks
    joins(%{
      INNER JOIN artwork_reblogs root 
          ON root.path = subpath(artwork_reblogs.path, 0, 1) })
      .joins("INNER JOIN artworks ON artworks.id = root.id")
      .where("artworks.id" => artworks)
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
      self.path = (ArtworkReblog.where(artwork: artwork).count).to_s
    else
      self.path = ArtworkReblog.find(ancestor_id).next_path
    end
  end
end

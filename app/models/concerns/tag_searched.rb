require "active_support/concern"

module TagSearched
  extend ActiveSupport::Concern

  included do
    def self.with_tags tag_ids
      tag_ids = tag_ids.pluck(:id) if tag_ids.is_a? ActiveRecord::Relation
      self.joins(:tags)
        .where(tags: {id: tag_ids})
    end
  end
end

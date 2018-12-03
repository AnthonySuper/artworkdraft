require "active_support/concern"

module Searched
  extend ActiveSupport::Concern

  included do
    def self.search search
      s = all
      return all unless search
      if respond_to?(:with_tags) && search["tags"]
        s = s.with_tags(search["tags"])
      end
      s
    end
  end
end

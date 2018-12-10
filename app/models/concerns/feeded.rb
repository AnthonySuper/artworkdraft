require "active_support/concern"

module Feeded
  extend ActiveSupport::Concern

  included do
    def self.feed_for user
      if user
        made_by(user.users_followed)
      else
        all
      end
    end

    def self.created_feed_for user
      made_by(user)
    end
  end
end

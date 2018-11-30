require "active_support/concern"

module Worksafe 
  extend ActiveSupport::Concern

  included do 
    def self.with_nsfw nsfw
      case nsfw
      when "required"
        where(nsfw: true)
      when "allowed", true
        all
      else
        where(nsfw: false)
      end
    end
  end
end

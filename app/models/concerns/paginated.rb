require "active_support/concern"

module Paginated
  extend ActiveSupport::Concern

  included do
    def self.paginate_order_raw ordering
      order(created_at: ordering).order(id: ordering)
    end

    def self.page_after timestamp
      paginate_order.where("created_at > ?", timestamp)
    end

    def self.paginate_order
      paginate_order_raw :desc
    end

    def self.reverse_paginate_order
      paginate_order_raw :asc
    end

    def self.page_before timestamp
      reverse_paginate_order.where("created_at < ?", timestamp)
    end
  end
end

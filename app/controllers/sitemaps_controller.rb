class SitemapsController < ApplicationController
  def index
    render template: "sitemaps/index.txt.erb"
  end

  def tags
    @tags = policy_scope(Tag).pluck(:id)
    render template: "sitemaps/tags.txt.erb"
  end

  def users 
    @users = policy_scope(User).pluck(:id)
    render template: "sitemaps/users.txt.erb"
  end

  def artworks
    @artworks = policy_scope(Artwork).pluck(:id)
    render template: "sitemaps/artworks.text.erb"
  end

  def scraps
    @scraps = policy_scope(Scrap).pluck(:id)
    render template: "sitemaps/scraps.text.erb"
  end
end

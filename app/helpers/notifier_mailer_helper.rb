module NotifierMailerHelper 
  def comment_link data
    id = data[:commented_id]
    case data[:commented_type]
    when "artwork"
      artwork_url id
    when "scrap"
      scrap_url id
    else
      root_url
    end
  end
end
    

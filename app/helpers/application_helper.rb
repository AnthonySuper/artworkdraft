module ApplicationHelper

  def page_title(title)
    provide(:title) { title }
  end

  def yield_page_title
    if content_for?(:title) then 
      content_for(:title) + ' | '
    else 
      ""
    end
  end

  def meta_tag(tag, text)
    provide :"meta_#{tag}", text
  end

  def tags_to_keywords tags
    tags.pluck(:name).join(",")
  end

  def yield_meta_tag(tag, default_text="")
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def og_tag(tag, text)
    provide :"og_#{tag}", text
  end

  def yield_og_tag(tag, default_text="")
    content_for?(:"og_#{tag}") ? content_for(:"og_#{tag}") : default_text
  end

  def render_markdown str
    (markdown_renderer.render str).html_safe
  end

  def default_meta_description
    %Q{ArtWorkDraft is a community of artists that's not run by a big corporation.
    It's the perfect place to post your paintings, drawings, fanart, and anything else you might create.}
  end

  protected

  def markdown_renderer
    @@markdown_renderer = 
      Redcarpet::Markdown.new(markdown_renderer_backend,
                              tables: true,
                              fenced_code_blocks: true,
                              autolink: true,
                              strikethrough: true,
                              superscript: true,
                              underline: true,
                              highlight: true,
                              footnotes: true)
  end

  def markdown_renderer_backend
    @@markdown_renderer_backend ||= 
      Redcarpet::Render::HTML.new(filter_html: true, safe_links_only: true)
  end
end

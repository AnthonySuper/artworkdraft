module ApplicationHelper

  def render_markdown str
    (markdown_renderer.render str).html_safe
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

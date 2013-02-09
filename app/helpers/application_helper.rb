module ApplicationHelper
  def current_page_profile?
    current_page?(edit_user_registration_path) || current_page?(profile_users_path)
  end

  def menu_item(title, path)
    css_class = "active" if current_page? path
    content_tag :li, class: css_class do
      link_to title, path
    end
  end

  def markdown(text)
    return "" unless text.present?

    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end

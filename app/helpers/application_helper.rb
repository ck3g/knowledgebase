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
end

module ApplicationHelper
  def current_page_profile?
    current_page?(edit_user_registration_path) || current_page?(profile_users_path)
  end
end

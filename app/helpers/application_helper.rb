# frozen_string_literal: true

module ApplicationHelper
  def admin_users_link
    if current_user.acts_as_admin?
      link_to 'Users', users_path
    else
      ''
    end
  end
end

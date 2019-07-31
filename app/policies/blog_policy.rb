# frozen_string_literal: true

class BlogPolicy < ApplicationPolicy
  def show?
    return true if update?

    record.published?
  end

  def update?
    return true if user&.acts_as_admin?

    record.user_id == user&.id
  end

  def destroy?
    update?
  end

  def create?
    user&.acts_as_author?
  end

  def permitted_attributes
    return base_attributes + %i[user_id] if user&.acts_as_admin?

    base_attributes
  end

  def base_attributes
    %i[
      title
      article
    ]
  end

  class Scope < Scope
    def resolve
      return scope if user&.acts_as_admin?
      return scope.published.or(user.blogs) if user&.acts_as_author?

      scope.published
    end
  end
end

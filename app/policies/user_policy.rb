# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    raise Pundit::NotAuthorizedError if user.nil?
    return true if user&.acts_as_admin?

    user == record
  end

  def update?
    raise Pundit::NotAuthorizedError if user.nil?

    show?
  end

  def destroy?
    raise Pundit::NotAuthorizedError if user.nil?

    user&.acts_as_admin?
  end

  def create?
    raise Pundit::NotAuthorizedError if user.nil?

    user&.acts_as_admin?
  end

  def permitted_attributes
    return base_attributes + %i[role] if user&.acts_as_admin?

    base_attributes
  end

  def base_attributes
    %i[
      display_name
      email
      password
      password_confirmation
      bio
    ]
  end

  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError if user.nil?
      return scope if user.acts_as_admin?

      scope.where(id: user.id)
    end
  end
end

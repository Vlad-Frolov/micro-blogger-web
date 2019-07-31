# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index; end

  private

    def current_user
      return nil if session[:user_id].blank?

      @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user

    def user_not_authorized
      flash.now[:error] = "You are not authorized to perform this action."

      redirect_to(request.referer || root_path)
    end
end

# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_after_action :verify_authorized

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in."
    else
      flash.now[:alert] = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged out."
  end
end

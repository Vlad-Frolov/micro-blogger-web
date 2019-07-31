# frozen_string_literal: true

module AuthTestHelper
  def sign_in_as(user)
    post sessions_url, params: { email: user.email, password: 'password' }
  end
end

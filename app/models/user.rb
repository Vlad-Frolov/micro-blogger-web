# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  display_name    :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  role            :integer          default("author"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#

class User < ApplicationRecord
  has_secure_password

  has_many :blogs, dependent: :destroy

  validates :display_name, presence: true
  validates :email, presence: true, email_format: true, uniqueness: true
  validates :password_confirmation, presence: true, if: ->(m) { m.password.present? }
  validates :role, presence: true

  enum role: {
    author: 0,
    admin: 2
  }

  def acts_as_admin?
    admin?
  end

  def acts_as_author?
    admin? || author?
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: blogs
#
#  id             :integer          not null, primary key
#  article        :text             not null
#  published_date :string           default(""), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_blogs_on_user_id  (user_id)
#

class Blog < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :user_id, inverse_of: :blogs

  scope :published, lambda {
    where("published_date <= ?", Time.zone.now)
      .where.not(published_date: '')
  }

  def published?
    return false if published_date.empty?

    Time.zone.parse(published_date) <= Time.zone.now
  end
end

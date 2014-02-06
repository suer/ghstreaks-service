class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :finders

  has_many :notifications

  def self.find_or_create(params)
    self.where(params).first || self.create(params)
  end
end

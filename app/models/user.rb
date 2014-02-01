class User < ActiveRecord::Base
  has_many :notifications
end

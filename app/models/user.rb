require_relative '../../lib/slug'

class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: true
  validates :email, format: {with: /\A(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))\z/i}

  has_many :tweets

  include Slug
  extend Slug
end

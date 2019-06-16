class User
  include Mongoid::Document

  has_many :videos, dependent: :destroy
  has_many :requests, dependent: :destroy
end

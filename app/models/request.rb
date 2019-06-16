class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUSES = { done: 1, failed: 2, scheduled: 3, processing: 4 }.freeze

  field :status, type: Integer, default: STATUSES[:scheduled]
  field :error, type: String
  field :trim_start, type: Integer
  field :trim_duration, type: Integer

  belongs_to :user
  belongs_to :video
end

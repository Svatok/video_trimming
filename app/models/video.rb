class Video
  include Mongoid::Document
  include VideoUploader::Attachment.new(:source_video)
  include VideoUploader::Attachment.new(:result_video)

  field :name, type: String
  field :source_video_data, type: String
  field :result_video_data, type: String

  belongs_to :user
end

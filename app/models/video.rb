class Video
  include Mongoid::Document
  include VideoUploader::Attachment.new(:source_video)

  field :name, type: String
  field :source_video_data, type: String

  belongs_to :user
end

module Video::Representer
  class Index < Lib::Representer::Base
    type 'videos'

    attributes :name

    attribute :url do
      @object.result_video_url
    end

    attribute :duration do
      @object.result_video.metadata['duration']
    end
  end
end

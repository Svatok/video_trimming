module Api
  module V1
    module VideosDoc
      extend Apipie::DSL::Concern

      api :GET, '/v1/videos', 'Show all videos'

      header 'Authorization', 'Bearer authorization_id', required: true

      def index; end

      api :POST, '/v1/videos', 'Create trimmed video'

      header 'Authorization', 'Bearer authorization_id', required: true

      param :name, String, required: true
      param :source_video, File, required: true
      param :trim_start, :number, required: true
      param :trim_duration, :number, required: true

      def create; end
    end
  end
end

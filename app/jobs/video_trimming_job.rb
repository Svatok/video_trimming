class VideoTrimmingJob < ApplicationJob
  queue_as :video_trimming

  def perform(request_id:)
    Video::Trim.call(request_id: request_id)
  end
end

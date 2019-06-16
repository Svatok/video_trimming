class Request::Restart < Trailblazer::Operation
  step :request!
  step :model!

  step :trim_video!

  def request!(ctx, current_user:, params:, **)
    ctx[:request] = current_user.requests.find_by(id: params[:request_id], status: Request::STATUSES[:failed])
  end

  def model!(ctx, current_user:, request:, **)
    params = {
      video: request.video,
      trim_start: request.trim_start,
      trim_duration: request.trim_duration
    }
    ctx[:model] = current_user.requests.create(params)
  end

  def trim_video!(_ctx, model:, **)
    VideoTrimmingJob.perform_later(request_id: model.id.to_s)
  end
end

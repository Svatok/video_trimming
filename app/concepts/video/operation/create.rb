class Video::Create < Trailblazer::Operation
  step :model!

  step Contract::Build(constant: Video::Contract::Create)
  step Contract::Validate(), fail_fast: true
  step Contract::Persist(method: :sync)

  step :file_valid?
  failure :add_errors!

  step Contract::Build(constant: Video::Contract::Trim)
  step Contract::Validate(), fail_fast: true

  step :save_source_video!

  step :create_request!
  step :trim_video!

  def model!(ctx, current_user:, **)
    ctx[:model] = current_user.videos.new
  end

  def file_valid?(_ctx, model:, **)
    model.valid?
  end

  def add_errors!(ctx, model:, **)
    model.errors[:source_video].each { |message| ctx['contract.default'].errors.add(:source_file, message) }
  end

  def save_source_video!(_ctx, model:, **)
    model.save
  end

  def create_request!(ctx, model:, current_user:, **)
    params = {
      video: model,
      trim_start: ctx['contract.default'].trim_start,
      trim_duration: ctx['contract.default'].trim_duration
    }
    ctx[:request] = current_user.requests.create(params)
  end

  def trim_video!(_ctx, request:, **)
    VideoTrimmingJob.perform_later(request_id: request.id.to_s)
  end
end

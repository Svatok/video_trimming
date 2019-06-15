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

  step Nested(proc { Video::Trim })

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
end

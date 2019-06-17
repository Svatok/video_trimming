class Video::Trim < Trailblazer::Operation
  step :request!, fail_fast: true
  step :start_request_processing!
  step :video!

  success :tmp_folder_path!
  step :tmp_path!

  step :trim_options!

  step Rescue(FFMPEG::Error, SourceVideoExistingError, handler: :log_error!) {
    step :source_video!
    step :trim_video!
    step :save_trimed_video!
  }, Output(:failure) => :stop_request_processing!

  step :stop_request_processing!
  success :remove_tmp_files!

  def request!(ctx, request_id:, **)
    ctx[:request] = Request.where(id: request_id).first
  end

  def start_request_processing!(_ctx, request:, **)
    request.update(status: Request::STATUSES[:processing])
  end

  def video!(ctx, request:, **)
    ctx[:video] = request.video
  end

  def tmp_folder_path!(ctx, **)
    ctx[:tmp_folder_path] = "#{::Rails.root}/tmp/trimmed_video/"
    FileUtils.mkdir_p(ctx[:tmp_folder_path]) unless Dir.exist?(ctx[:tmp_folder_path])
  end

  def tmp_path!(ctx, video:, tmp_folder_path:, **)
    ctx[:tmp_path] = "#{tmp_folder_path}#{video.source_video.metadata['filename']}"
  end

  def trim_options!(ctx, request:, **)
    ctx[:trim_options] = ['-ss', request.trim_start.to_s, '-t', request.trim_duration.to_s]
  end

  def source_video!(ctx, video:, **)
    raise SourceVideoExistingError unless video.source_video.exists?

    ctx[:source_video] = video.source_video.download
  end

  def trim_video!(_ctx, source_video:, tmp_path:, trim_options:, **)
    trimed_video = FFMPEG::Movie.new(source_video.path)
    trimed_video.transcode(tmp_path, trim_options)
  end

  def log_error!(exception, (ctx), *)
    ctx[:request].error = exception.message
  end

  def save_trimed_video!(_ctx, video:, tmp_path:, **)
    video.update(result_video: File.open(tmp_path, 'r'))
  end

  def stop_request_processing!(_ctx, request:, **)
    status = request.error.present? ? Request::STATUSES[:failed] : Request::STATUSES[:done]
    request.update(status: status)
  end

  def remove_tmp_files!(ctx, tmp_folder_path:, **)
    File.delete(ctx[:source_video].path) if ctx[:source_video].present? && File.exist?(ctx[:source_video].path)
    FileUtils.rm_rf(tmp_folder_path) if Dir.exist?(tmp_folder_path)
  end
end

class Video::Trim < Trailblazer::Operation
  step :video!

  success :tmp_folder_path!
  step :tmp_path!

  step :trim_options!

  step :trim_video!
  step :save_trimed_video!

  step :remove_tmp_file!

  def video!(ctx, model:, **)
    ctx[:video] = model.source_video
  end

  def tmp_folder_path!(ctx, **)
    ctx[:tmp_folder_path] = "#{::Rails.root}/tmp/trimmed_video/"
    FileUtils.mkdir_p(ctx[:tmp_folder_path]) unless Dir.exist?(ctx[:tmp_folder_path])
  end

  def tmp_path!(ctx, video:, tmp_folder_path:, **)
    ctx[:tmp_path] = "#{tmp_folder_path}#{video.metadata['filename']}"
  end

  def trim_options!(ctx, **)
    contract = ctx['contract.default']
    ctx[:trim_options] = ['-ss', contract.trim_start.to_s, '-t', contract.trim_duration.to_s]
  end

  def trim_video!(_ctx, video:, tmp_path:, trim_options:, **)
    trimed_video = FFMPEG::Movie.new(video.url)
    trimed_video.transcode(tmp_path, trim_options)
  end

  def save_trimed_video!(_ctx, model:, tmp_path:, **)
    model.update(result_video: File.open(tmp_path, 'r'))
  end

  def remove_tmp_file!(_ctx, tmp_folder_path:, **)
    FileUtils.rm_rf(tmp_folder_path) if Dir.exist?(tmp_folder_path)
  end
end

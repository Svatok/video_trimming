class Video::Index < Trailblazer::Operation
  step :model!
  step :prepare_renderer!
  step Lib::Macro::SerializeModel()

  def model!(ctx, current_user:, **)
    ctx[:model] = current_user.videos.not_in(result_video_data: nil)
  end

  def prepare_renderer!(ctx, **)
    ctx[:renderer_options] = { class: { Video: Video::Representer::Index } }
  end
end

class Request::Index < Trailblazer::Operation
  step :model!
  step :prepare_renderer!
  step Lib::Macro::SerializeModel()

  def model!(ctx, current_user:, **)
    ctx[:model] = current_user.requests
  end

  def prepare_renderer!(ctx, **)
    ctx[:renderer_options] = { class: { Request: Request::Representer::Index } }
  end
end

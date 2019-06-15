class User::Create < Trailblazer::Operation
  step :model!
  step :prepare_renderer!
  step Lib::Macro::SerializeModel()

  def model!(ctx, **)
    ctx[:model] = User.create
  end

  def prepare_renderer!(ctx, **)
    ctx[:renderer_options] = { class: { User: User::Representer::Create } }
  end
end

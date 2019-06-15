module Lib::Macro::SerializeModel
  def self.call
    step = ->(ctx, model:, renderer_options:, **) {
      ctx[:serialized_model] = JSONAPI::Serializable::Renderer.new.render(model, renderer_options)
    }
    task = Trailblazer::Activity::TaskBuilder::Binary(step)
    { task: task, id: 'serialized_model' }
  end
end

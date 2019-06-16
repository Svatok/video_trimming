class Video::Contract::Create < Reform::Form
  feature Reform::Form::Dry
  feature Coercion

  property :name
  property :source_video
  property :trim_start, virtual: true, type: Types::Form::Int
  property :trim_duration, virtual: true, type: Types::Form::Int

  validation do
    required(:name).filled(:str?)
    required(:source_video).filled
    required(:trim_start).filled(:int?, gteq?: 0)
    required(:trim_duration).filled(:int?, gt?: 0)
  end
end

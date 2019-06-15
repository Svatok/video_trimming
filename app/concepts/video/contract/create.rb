class Video::Contract::Create < Reform::Form
  feature Reform::Form::Dry

  property :source_video

  validation do
    required(:source_video).filled
  end
end

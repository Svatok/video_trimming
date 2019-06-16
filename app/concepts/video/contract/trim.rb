class Video::Contract::Trim < Reform::Form
  feature Reform::Form::Dry
  feature Coercion

  property :trim_start, virtual: true, type: Types::Form::Int
  property :trim_duration, virtual: true, type: Types::Form::Int

  validation do
    configure do
      option :form

      def valid_trim_start?(value)
        value < form.model.source_video.metadata['duration']
      end
    end

    required(:trim_start).filled(:valid_trim_start?)
  end
end

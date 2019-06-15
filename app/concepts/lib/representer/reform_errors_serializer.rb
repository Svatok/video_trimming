module Lib::Representer
  class ReformErrorsSerializer
    def initialize(exposures)
      @errors = exposures[:object].messages
    end

    def as_jsonapi
      formatted_errors = errors.map do |field, messages|
        compose_errors(messages, field)
      end
      formatted_errors.flatten
    end

    private

    attr_reader :errors

    def compose_errors(messages, field)
      messages.map do |message|
        ErrorRepresenter.new(field: field, message: message).as_jsonapi
      end
    end
  end
end

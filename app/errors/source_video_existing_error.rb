class SourceVideoExistingError < StandardError
  def initialize
    super(I18n.t('errors.source_video_not_exists'))
  end
end

class ApplicationUploader < Shrine
  plugin :default_url
  plugin :validation_helpers
  plugin :determine_mime_type
  plugin :add_metadata
  plugin :processing
  plugin :default_url_options, store: { host: 'http://localhost:3000' }
end

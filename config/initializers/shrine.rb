require 'shrine'
require 'shrine/storage/file_system'

Shrine.plugin :mongoid

if ENV['RAILS_ENV'] == 'development'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
  }
  Shrine.plugin :default_url_options, store: { host: 'http://localhost:3000' }
end

if ENV['RAILS_ENV'] == 'test'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

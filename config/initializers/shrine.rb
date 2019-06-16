require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'

Shrine.plugin :mongoid

if ENV['RAILS_ENV'] == 'development'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
  }
end

if ENV['RAILS_ENV'] == 'test'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

class VideoUploader < ApplicationUploader
  add_metadata :duration do |io, _context|
    FFMPEG::Movie.new(io.path).duration
  end

  Attacher.validate do
    validate_extension_inclusion %w[mp4 3gp mkv webm avi]
  end
end

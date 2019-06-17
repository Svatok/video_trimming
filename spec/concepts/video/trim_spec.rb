require 'rails_helper'

RSpec.describe Video::Trim do
  let(:user) { create :user }
  let(:video) { create :video, :with_source_video, user: user }
  let(:request) { create :request, video: video, user: user }

  subject { described_class.call(request_id: request_id) }

  describe 'Failure' do
    context 'request not found' do
      let(:request_id) { 0 }

      it 'returns failure' do
        expect(subject).to be_failure
      end
    end

    context 'ffmpeg returns error' do
      let(:request_id) { request.id.to_s }

      before do
        allow_any_instance_of(FFMPEG::Movie).to receive(:transcode).and_raise(FFMPEG::Error)
      end

      it 'log error and update status' do
        expect { subject }.to change { request.reload.status }
          .from(Request::STATUSES[:scheduled]).to(Request::STATUSES[:failed])
          .and(not_change { video.reload.result_video_url })
        expect(Dir.exist?(subject[:tmp_folder_path])).to be_falsey
        expect(subject).to be_success
      end
    end

    context 'file not present' do
      let(:request_id) { request.id.to_s }

      before { allow_any_instance_of(VideoUploader::UploadedFile).to receive(:exists?).and_return(false) }

      it 'log error and update status' do
        expect { subject }.to change { request.reload.status }
          .from(Request::STATUSES[:scheduled]).to(Request::STATUSES[:failed])
          .and change { request.reload.error }
          .from(nil).to(be_kind_of(String))
          .and(not_change { video.reload.result_video_url })
        expect(Dir.exist?(subject[:tmp_folder_path])).to be_falsey
        expect(subject).to be_success
      end
    end
  end

  describe 'Success' do
    let(:request_id) { request.id.to_s }

    it 'trimms video and update status' do
      expect { subject }.to change { video.reload.result_video_url }
        .from(nil).to(be_kind_of(String))
        .and change { request.reload.status }
        .from(Request::STATUSES[:scheduled]).to(Request::STATUSES[:done])
      expect(subject[:video].result_video_url).not_to be_nil
      expect(subject[:video].result_video.metadata['duration']).to be_within(0.1).of(request.trim_duration)
      expect(Dir.exist?(subject[:tmp_folder_path])).to be_falsey
      expect(File.exist?(subject[:source_video].path)).to be_falsey
      expect(subject).to be_success
    end
  end
end

require 'rails_helper'

RSpec.describe Video::Create do
  let(:user) { create :user }

  subject { described_class.call(params: params, current_user: user) }

  describe 'Failure' do
    context 'wrong params' do
      let(:params) do
        { source_video: nil }
      end

      let(:errors) do
        { source_video: ['must be filled'] }
      end

      it 'returns errors' do
        expect { subject }.to not_change(user.videos, :count)
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to eq errors
      end
    end

    context 'wrong file format' do
      let(:params) do
        { source_video: fixture_file_upload('files/avatar.png', 'image/png') }
      end

      let(:errors) do
        { source_file: ["isn't of allowed format (allowed formats: mp4, 3gp, mkv, webm, avi)"] }
      end

      it 'returns errors' do
        expect { subject }.to not_change(user.videos, :count)
        expect(subject).to be_failure
        expect(subject['contract.default'].errors.messages).to eq errors
      end
    end
  end

  describe 'Success' do
    let(:params) do
      { source_video: fixture_file_upload('files/test_video.mp4', 'video/mp4') }
    end

    it 'creates video' do
      expect { subject }.to change(user.videos, :count).from(0).to(1)
      expect(subject[:model].source_video_url).not_to be_nil
      expect(subject).to be_success
    end
  end
end

require 'rails_helper'

RSpec.describe Video::Create do
  let(:user) { create :user }

  subject { described_class.call(params: params, current_user: user) }

  describe 'Failure' do
    context 'wrong params' do
      context 'empty params' do
        let(:params) { {} }

        let(:errors) do
          {
            source_video: ['must be filled'],
            trim_duration: ['must be filled', 'must be greater than 0'],
            trim_start: ['must be filled', 'must be greater than or equal to 0']
          }
        end

        it 'returns errors' do
          expect { subject }.to not_change(user.videos, :count)
          expect(subject).to be_failure
          expect(subject['contract.default'].errors.messages).to eq errors
        end
      end

      context 'wrong trim_start param' do
        let(:params) do
          {
            source_video: fixture_file_upload('files/test_video.mp4', 'video/mp4'),
            trim_start: 50,
            trim_duration: 30
          }
        end

        let(:errors) do
          {
            trim_start: ['trim_start param is not valid']
          }
        end

        it 'returns errors' do
          expect { subject }.to not_change(user.videos, :count)
          expect(subject).to be_failure
          expect(subject['contract.default'].errors.messages).to eq errors
        end
      end

      context 'wrong file format' do
        let(:params) do
          {
            source_video: fixture_file_upload('files/avatar.png', 'image/png'),
            trim_start: 1,
            trim_duration: 2
          }
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
  end

  describe 'Success' do
    let(:params) do
      {
        source_video: fixture_file_upload('files/test_video.mp4', 'video/mp4'),
        trim_start: 0,
        trim_duration: 5
      }
    end

    before do
      allow_any_instance_of(VideoUploader::UploadedFile).to receive(:url)
        .and_return(Rails.root.join('spec', 'fixtures', 'files', 'test_video.mp4').to_s)
    end

    it 'creates video' do
      expect { subject }.to change(user.videos, :count).from(0).to(1)
      expect(subject[:model].source_video_url).not_to be_nil
      expect(subject[:model].source_video.metadata['duration']).not_to be_nil
      expect(subject[:model].result_video_url).not_to be_nil
      expect(subject[:model].result_video.metadata['duration']).to be_within(0.1).of(params[:trim_duration])
      expect(subject).to be_success
    end
  end
end

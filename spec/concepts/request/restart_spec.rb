require 'rails_helper'

RSpec.describe Request::Restart do
  let(:user) { create :user }
  let(:video) { create :video, :with_source_video, user: user }

  subject { described_class.call(params: params, current_user: user) }

  describe 'Failure' do
    context 'request not found' do
      context 'without id' do
        let(:params) { {} }

        specify { expect { subject }.to raise_error(Mongoid::Errors::DocumentNotFound) }
      end

      context 'wrong id' do
        let(:params) { { request_id: 'test' } }

        specify { expect { subject }.to raise_error(Mongoid::Errors::DocumentNotFound) }
      end

      context 'request is not failed' do
        let(:request) { create :request, user: user, video: video, status: Request::STATUSES[:done] }

        let(:params) { { request_id: request.id.to_s } }

        specify { expect { subject }.to raise_error(Mongoid::Errors::DocumentNotFound) }
      end
    end
  end

  describe 'Success' do
    let!(:request) { create :request, video: video, user: user, status: Request::STATUSES[:failed] }
    let(:params) { { request_id: request.id.to_s } }

    it 'restarts request' do
      expect { subject }.to change(user.requests, :count)
        .from(1).to(2)
        .and(not_change(user.videos, :count))
      expect(subject[:model].trim_start).to eq request.trim_start
      expect(subject[:model].trim_start).to eq request.trim_start
      expect(subject[:model].video).to eq video
      expect(subject[:model].status).to eq Request::STATUSES[:scheduled]
      expect(VideoTrimmingJob).to have_been_enqueued.with(request_id: subject[:model].id)
      expect(subject).to be_success
    end
  end
end

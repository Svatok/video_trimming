require 'rails_helper'

RSpec.describe Request::Index do
  let(:user) { create :user }

  let(:video1) { create :video, user: user }
  let!(:request1) { create :request, video: video1, user: user }

  let(:video2) { create :video, user: user }
  let!(:request2) { create :request, video: video2, user: user, status: Request::STATUSES[:failed] }

  let(:another_user) { create :user }

  let(:video3) { create :video, user: another_user }
  let!(:request3) { create :request, video: video3, user: another_user, status: Request::STATUSES[:failed] }

  context 'success' do
    subject { described_class.call(current_user: user) }

    it 'returns requests' do
      expect(subject[:model]).to match_array([request1, request2])
      expect(subject).to be_success
    end
  end
end

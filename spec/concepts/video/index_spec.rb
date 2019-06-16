require 'rails_helper'

RSpec.describe Video::Index do
  let(:user) { create :user }

  let!(:video1) { create :video, :with_result_video, user: user }
  let!(:video2) { create :video, user: user }

  let(:another_user) { create :user }
  let!(:video3) { create :video, user: another_user }

  context 'success' do
    subject { described_class.call(current_user: user) }

    it 'returns videos' do
      expect(subject[:model]).to match_array([video1])
      expect(subject).to be_success
    end
  end
end

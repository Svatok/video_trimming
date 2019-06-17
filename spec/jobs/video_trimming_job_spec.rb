RSpec.describe VideoTrimmingJob, type: :job do
  let(:user) { create :user }
  let(:video) { create :video, :with_source_video, user: user }
  let!(:request) { create :request, video: video, user: user }

  subject { described_class.perform_later(request_id: request.id.to_s) }

  it 'queues job' do
    expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).from(0).to(1)
    expect(described_class.new.queue_name).to eq('video_trimming')
  end

  context '#perform' do
    subject { described_class.new }

    it 'calls operation' do
      expect(Video::Trim).to receive(:call)
      subject.perform(request_id: request.id.to_s)
    end
  end
end

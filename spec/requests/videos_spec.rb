RSpec.describe 'Videos', type: :request do
  let(:user) { create :user }
  let(:authorization_header) { authorization_header_for(user) }

  describe 'POST #create' do
    describe 'Failure' do
      let(:params) do
        { source_video: nil }
      end

      before do
        post api_v1_videos_path, params: params, headers: authorization_header
      end

      it 'renders errors', :show_in_doc do
        expect(response).to be_unprocessable
        expect(response).to match_schema('v1/errors')
      end
    end

    describe 'Success' do
      let(:params) do
        { source_video: fixture_file_upload('files/test_video.mp4', 'video/mp4') }
      end

      before do
        post api_v1_videos_path, params: params, headers: authorization_header
      end

      it 'creates user' do
        expect(response).to be_created
        expect(response.body).to be_empty
      end
    end
  end
end

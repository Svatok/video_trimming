RSpec.describe 'Requests', :show_in_doc, type: :request do
  let(:user) { create :user }
  let(:authorization_header) { authorization_header_for(user) }

  describe 'GET #index' do
    describe 'Failure' do
      context 'unauthenticated' do
        before do
          get api_v1_requests_path, headers: { Authorization: 'Bearer test' }
        end

        it 'renders errors' do
          expect(response).to be_unauthorized
        end
      end
    end

    describe 'Success' do
      let(:video1) { create :video, user: user }
      let!(:request1) { create :request, video: video1, user: user }

      let(:video2) { create :video, user: user }
      let!(:request2) { create :request, video: video2, user: user, status: Request::STATUSES[:failed] }

      before do
        get api_v1_requests_path, headers: authorization_header
      end

      it 'returns requests' do
        expect(response).to be_ok
        expect(response).to match_schema('v1/requests/index')
      end
    end
  end
end

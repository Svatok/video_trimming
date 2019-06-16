RSpec.describe 'Restarting', type: :request do
  let(:user) { create :user }
  let(:video) { create :video, :with_source_video, user: user }
  let(:authorization_header) { authorization_header_for(user) }

  describe 'POST #create' do
    describe 'Failure' do
      context 'unauthenticated' do
        before do
          post api_v1_request_restarting_path(request_id: 'request_id')
        end

        it 'renders errors', :show_in_doc do
          expect(response).to be_unauthorized
        end
      end

      context 'wrong id' do
        let(:request_id) { 'test' }

        before do
          post api_v1_request_restarting_path(request_id: request_id), headers: authorization_header
        end

        it 'renders errors', :show_in_doc do
          expect(response).to be_not_found
        end
      end
    end

    describe 'Success' do
      let!(:request) { create :request, video: video, user: user, status: Request::STATUSES[:failed] }
      let(:request_id) { request.id.to_s }

      before do
        post api_v1_request_restarting_path(request_id: request_id), headers: authorization_header
      end

      it 'creates user' do
        expect(response).to be_created
        expect(response.body).to be_empty
      end
    end
  end
end

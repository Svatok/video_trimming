RSpec.describe 'Users', :show_in_doc, type: :request do
  describe 'POST #create' do
    before { post api_v1_users_path }

    describe 'Success' do
      it 'creates user' do
        expect(response).to be_ok
        expect(response).to match_schema('v1/users/create')
      end
    end
  end
end

module Api
  module V1
    module UsersDoc
      extend Apipie::DSL::Concern

      api :POST, '/v1/users', 'Create user (create new identificator)'

      def create; end
    end
  end
end

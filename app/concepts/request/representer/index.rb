module Request::Representer
  class Index < Lib::Representer::Base
    type 'requests'

    attributes :created_at

    attribute :status do
      ::Request::STATUSES.key(@object.status)
    end
  end
end

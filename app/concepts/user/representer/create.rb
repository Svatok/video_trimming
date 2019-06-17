module User::Representer
  class Create < Lib::Representer::Base
    type 'users'

    attribute :identificator do
      @object.id.to_s
    end
  end
end

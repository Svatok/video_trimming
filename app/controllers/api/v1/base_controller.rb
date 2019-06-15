module Api
  module V1
    class BaseController < ::ActionController::API
      include Trailblazer::Rails::Controller
    end
  end
end
